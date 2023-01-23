import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forum_hub/features/auth/controller/auth_controller.dart';
import 'package:forum_hub/features/community/repository/communitory_repository.dart';
import 'package:forum_hub/models/community_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';
import '../../../core/components/constants.dart';
import '../../../core/failure.dart';
import '../../../core/providers/storage_repository_provider.dart';
import '../../../core/utils.dart';
import '../../../models/post_model.dart';

final userCommunitiesProvider = StreamProvider((ref) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getUserCommunities();
});


final communityControllerProvider = StateNotifierProvider<CommunityController, bool>((ref) {
  final communityRepository = ref.watch(communityRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return CommunityController(
      communityRepository: communityRepository,
      storageRepository: storageRepository,
      ref: ref);
});

final getCommunityByNameProvider = StreamProvider.family((ref, String name){
  return ref.watch(communityControllerProvider.notifier).getCommunityByName(name);
});

final searchCommunityProvider = StreamProvider.family((ref, String query){

  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
});

final getCommunityPostsProvider = StreamProvider.family((ref, String name) {
  return ref.read(communityControllerProvider.notifier).getCommunityPosts(name);
});

class CommunityController extends StateNotifier<bool>{
  final CommunityRepository _communityRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  CommunityController({
    required CommunityRepository communityRepository,
    required StorageRepository storageRepository,
    required Ref ref})
      :
        _communityRepository = communityRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);

  void createCommunity(String name, BuildContext context) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? '';
    Community community = Community(
        id: name,
        name: name,
        banner: Constants.bannerDefault,
        avatar: Constants.avatarDefault,
        members: [uid],
        mods: [uid]);
    final res = await _communityRepository.createCommunity(community);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Group Created Sucessfully!!');
      Routemaster.of(context).pop();
    });
  }

  void joinCommunity(Community community, BuildContext context) async {
    final user = _ref.read(userProvider)!;
    Either<Failure,void> res;
    if(community.members.contains(user.uid)){
     res = await _communityRepository.leaveCommunity(community.name, user.uid);
    }else{
      res = await _communityRepository.joinCommunity(community.name, user.uid);
    }
    res.fold((l) => showSnackBar(context, l.message),
            (r) {
            if(community.members.contains(user.uid)){
            showSnackBar(context, 'Community Left Sucessfully!!');
            }else{
              showSnackBar(context, 'Community Joined Sucessfully!!');
            }
            });
}
  Stream<List<Community>> getUserCommunities() {
    final uid = _ref.read(userProvider)!.uid;
    return _communityRepository.getUserCommunities(uid);
  }
  Stream<Community> getCommunityByName(String name){
    return _communityRepository.getCommunityByName(name);
  }
  void editCommunity({
    required File? profileFile,
    required File? bannerFile,
    required Uint8List? profileWebFile,
    required Uint8List? bannerWebFile,
    required BuildContext context,
    required Community community,
  }) async {
    state = true;
    if (profileFile != null || profileWebFile != null) {
      // communities/profile/memes
      final res = await _storageRepository.storeFile(
        path: 'community/profile',
        id: community.name,
        file: profileFile,
        webFile: null,
      );
      res.fold(
            (l) => showSnackBar(context, l.message),
            (r) => community = community.copyWith(avatar: r),
      );
    }
    if(bannerFile != null) {
      final res = await _storageRepository.storeFile(path: 'community/banner',
        id: community.banner,
        file: bannerFile,
        webFile: bannerWebFile,
      );
      res.fold(
            (l) => showSnackBar(context, l.message),
            (r) => community = community.copyWith(banner: r),
      );
    }
    final res = await _communityRepository.editCommunity(community);
    state = false;
    res.fold(
          (l) => showSnackBar(context, l.message),
          (r) => Routemaster.of(context).pop(),
    );
  }
  Stream<List<Community>> searchCommunity(String query){
    return _communityRepository.searchCommunity(query);
  }
  void addMods(String communityName, List<String> uids, BuildContext context) async{
    final res = await _communityRepository.addMods(communityName, uids);
    res.fold(
            (l)=> showSnackBar(context,l.message),
            (r)=>Routemaster.of(context).pop(),
    );
  }
  Stream<List<Post>> getCommunityPosts(String name) {
    return _communityRepository.getCommunityPosts(name);
  }
}