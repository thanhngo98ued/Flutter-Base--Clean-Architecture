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
    apiKey: 'AIzaSyD-4uQoPPI_Q2zuA4tnl7C9BgXnWzBMcf0',
    appId: '1:562683139335:web:eff42c4b7d8080da64e1a2',
    messagingSenderId: '562683139335',
    projectId: 'base-flutter-2e1f4',
    authDomain: 'base-flutter-2e1f4.firebaseapp.com',
    storageBucket: 'base-flutter-2e1f4.firebasestorage.app',
    measurementId: 'G-WKXW4RWTKK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC--3JGbYF6I5uUtJOCEMudNr2ToNVQwqw',
    appId: '1:562683139335:android:cdccc659113aa46064e1a2',
    messagingSenderId: '562683139335',
    projectId: 'base-flutter-2e1f4',
    storageBucket: 'base-flutter-2e1f4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPyAzYqd7iQmVfXN5UFvmkCJ5zQseVSFA',
    appId: '1:562683139335:ios:d10037dc28704d7264e1a2',
    messagingSenderId: '562683139335',
    projectId: 'base-flutter-2e1f4',
    storageBucket: 'base-flutter-2e1f4.firebasestorage.app',
    iosBundleId: 'com.dreamclippers.baseflutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPyAzYqd7iQmVfXN5UFvmkCJ5zQseVSFA',
    appId: '1:562683139335:ios:d10037dc28704d7264e1a2',
    messagingSenderId: '562683139335',
    projectId: 'base-flutter-2e1f4',
    storageBucket: 'base-flutter-2e1f4.firebasestorage.app',
    iosBundleId: 'com.dreamclippers.baseflutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-4uQoPPI_Q2zuA4tnl7C9BgXnWzBMcf0',
    appId: '1:562683139335:web:bb17e493b3815b4e64e1a2',
    messagingSenderId: '562683139335',
    projectId: 'base-flutter-2e1f4',
    authDomain: 'base-flutter-2e1f4.firebaseapp.com',
    storageBucket: 'base-flutter-2e1f4.firebasestorage.app',
    measurementId: 'G-J0DZS5ZBZH',
  );
}
