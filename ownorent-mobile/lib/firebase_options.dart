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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCFc8w7RfjJetE9IEHQe9adDF-DUwwmFBU',
    appId: '1:502323139497:web:0f6a4f2d992c1ebe56eab8',
    messagingSenderId: '502323139497',
    projectId: 'ownorent-d6961',
    authDomain: 'ownorent-d6961.firebaseapp.com',
    storageBucket: 'ownorent-d6961.appspot.com',
    measurementId: 'G-QYNYJFYR46',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAK_EC4GaASX3j2dScwNDPmRMAKHFxzdS8',
    appId: '1:502323139497:android:39281919ebcf470a56eab8',
    messagingSenderId: '502323139497',
    projectId: 'ownorent-d6961',
    storageBucket: 'ownorent-d6961.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCfv2uBaixjD8IoCYn-lbm8A9TPKh7ycko',
    appId: '1:502323139497:ios:c57c54ce146d92cf56eab8',
    messagingSenderId: '502323139497',
    projectId: 'ownorent-d6961',
    storageBucket: 'ownorent-d6961.appspot.com',
    iosClientId: '502323139497-arl1360uvc83iudpf9femp5bhp7quhdq.apps.googleusercontent.com',
    iosBundleId: 'com.example.ownorent',
  );
}
