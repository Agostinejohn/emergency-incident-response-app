// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import "package:flutter/foundation.dart"
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
        return windows;
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
    apiKey: 'AIzaSyAb3TtKBiHU3tOfVhMGYaGChesdSHej6Q0',
    appId: '1:939643688007:web:3204287505bbf8c7180d62',
    messagingSenderId: '939643688007',
    projectId: 'friday-955d2',
    authDomain: 'friday-955d2.firebaseapp.com',
    storageBucket: 'friday-955d2.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoTLjbK1qsRAdP5kftT6yqWG_a_lUVqzI',
    appId: '1:939643688007:android:180c5e334a7523ab180d62',
    messagingSenderId: '939643688007',
    projectId: 'friday-955d2',
    storageBucket: 'friday-955d2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnCiHgK9D-bgUYgDwP00KcUffwMhvXVWM',
    appId: '1:939643688007:ios:5cb2ef7115b34155180d62',
    messagingSenderId: '939643688007',
    projectId: 'friday-955d2',
    storageBucket: 'friday-955d2.firebasestorage.app',
    iosBundleId: 'com.example.emegencyIncidentResponceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnCiHgK9D-bgUYgDwP00KcUffwMhvXVWM',
    appId: '1:939643688007:ios:5cb2ef7115b34155180d62',
    messagingSenderId: '939643688007',
    projectId: 'friday-955d2',
    storageBucket: 'friday-955d2.firebasestorage.app',
    iosBundleId: 'com.example.emegencyIncidentResponceApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAb3TtKBiHU3tOfVhMGYaGChesdSHej6Q0',
    appId: '1:939643688007:web:921ad3c52cf3aaea180d62',
    messagingSenderId: '939643688007',
    projectId: 'friday-955d2',
    authDomain: 'friday-955d2.firebaseapp.com',
    storageBucket: 'friday-955d2.firebasestorage.app',
  );
}
