import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forum_hub/core/common/post_card.dart';
import 'package:forum_hub/features/post/controller/post_controller.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../models/post_model.dart';
import '../widgets/comment_card.dart';

class CommentScreen extends ConsumerStatefulWidget{
  final String postId;
  const CommentScreen({super.key, required this.postId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentsScreenState();
}
class _CommentsScreenState extends ConsumerState<CommentScreen>{
  final commentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentController.dispose();
  }

  void addComment(Post post) {
    ref.read(postControllerProvider.notifier).addComment(
      context: context,
      text: commentController.text.trim(),
      post: post,
    );
    setState(() {
      commentController.text = '';
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(getPostByIdProvider(widget.postId)).when(
          data:(data){
            return Column(

              children: [
                PostCard(post: data),
                const SizedBox(height: 10),
                TextField(
                  onSubmitted:(val) => addComment(data),
                  controller: commentController,
                  decoration: const InputDecoration(
                    hintText: "Type Your Thoughts !!",
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
                ref.watch(getPostCommentsProvider(widget.postId)).when(
                  data: (data) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final comment = data[index];
                          return CommentCard(comment: comment);
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                 return ErrorText(
                   error: error.toString(),
                 );
                  },
                  loading: () => const Loader(),
                ),
              ],
            );
      },
        error: (error, stackTrace) => ErrorText(
          error: error.toString(),
        ),
        loading: () => const Loader(),
      ),
    );
  }
}