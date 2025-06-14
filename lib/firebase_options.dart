// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCzyoQmmRngpVRg_ANUI938rpv-83VwAew',
    appId: '1:871728803084:web:89671b1f54068e01e62d29',
    messagingSenderId: '871728803084',
    projectId: 'sosialapp-59aaa',
    authDomain: 'sosialapp-59aaa.firebaseapp.com',
    storageBucket: 'sosialapp-59aaa.firebasestorage.app',
    measurementId: 'G-37YN5HF7H2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnb9fD3lUIcmdymzA_Z2bLxtI5U8cbkRM',
    appId: '1:871728803084:android:d8888f26df4eac1fe62d29',
    messagingSenderId: '871728803084',
    projectId: 'sosialapp-59aaa',
    storageBucket: 'sosialapp-59aaa.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOWbf1vu995Wvxyu5m1cq6tYk_BS9AddU',
    appId: '1:871728803084:ios:42d696eb9cce1aaee62d29',
    messagingSenderId: '871728803084',
    projectId: 'sosialapp-59aaa',
    storageBucket: 'sosialapp-59aaa.firebasestorage.app',
    iosBundleId: 'com.example.socialmediaapp',
  );
}
