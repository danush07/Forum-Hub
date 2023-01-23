import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forum_hub/core/components/constants.dart';
import 'package:forum_hub/features/auth/controller/auth_controller.dart';

import '../../../core/common/loader.dart';
import '../../../core/common/sign_in_button.dart';



class LoginScreen extends ConsumerWidget {
const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(Constants.logoPath,
        height: 90,),
        actions: [
          TextButton(onPressed: () {},
           child: const Text('Skip', 
           style: TextStyle(
            fontWeight: FontWeight.bold,
           ),),
           )
        ],
      ),  body : isLoading?
          const Loader()
        : Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Connecting you to the cutting edge !',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    Constants.loginEmotePath,
                    height: 400,
                  ),
                ),
                const SizedBox(height: 20),
                const SignInButton(),
              ],
            ),
    );
  }
}