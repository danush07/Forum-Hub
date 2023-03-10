// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBvkUE2UJTlOQeXPk-HS8ha-xHfRm1cNKU',
    appId: '1:701978128941:web:1abdc762d5e4cd3ac7fea4',
    messagingSenderId: '701978128941',
    projectId: 'forum-hub-becae',
    authDomain: 'forum-hub-becae.firebaseapp.com',
    storageBucket: 'forum-hub-becae.appspot.com',
    measurementId: 'G-N5PEW3EP2G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAECHg6SOTBqsha6SfRW0tbsV9wNRTUIMY',
    appId: '1:701978128941:android:5a16f8f1fa6ff9a1c7fea4',
    messagingSenderId: '701978128941',
    projectId: 'forum-hub-becae',
    storageBucket: 'forum-hub-becae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCY_w3_RDonM_meX7jGgvxhrJsn6ipA1jQ',
    appId: '1:701978128941:ios:3a7cde9bded30a0ec7fea4',
    messagingSenderId: '701978128941',
    projectId: 'forum-hub-becae',
    storageBucket: 'forum-hub-becae.appspot.com',
    androidClientId: '701978128941-0dhl1hmhgo5fth8j6a8rmtdbhsseflko.apps.googleusercontent.com',
    iosClientId: '701978128941-suvqmdml0sveh4hvnask8lrinmrlql9f.apps.googleusercontent.com',
    iosBundleId: 'com.example.forumHub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCY_w3_RDonM_meX7jGgvxhrJsn6ipA1jQ',
    appId: '1:701978128941:ios:3a7cde9bded30a0ec7fea4',
    messagingSenderId: '701978128941',
    projectId: 'forum-hub-becae',
    storageBucket: 'forum-hub-becae.appspot.com',
    androidClientId: '701978128941-0dhl1hmhgo5fth8j6a8rmtdbhsseflko.apps.googleusercontent.com',
    iosClientId: '701978128941-suvqmdml0sveh4hvnask8lrinmrlql9f.apps.googleusercontent.com',
    iosBundleId: 'com.example.forumHub',
  );
}
