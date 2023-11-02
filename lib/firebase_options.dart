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
    apiKey: 'AIzaSyD0hF5EXX1KsEdzaOGilKOHGfczVmv8dNA',
    appId: '1:932250959407:web:5b5fa9dcd2b50b0ac010da',
    messagingSenderId: '932250959407',
    projectId: 'd-configurator-1731d',
    authDomain: 'd-configurator-1731d.firebaseapp.com',
    storageBucket: 'd-configurator-1731d.appspot.com',
    measurementId: 'G-4TPQHTP9RY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_2C_nyxSjep8O1mPoqAutd3a6-zMpES0',
    appId: '1:932250959407:android:7ef6614589fc7596c010da',
    messagingSenderId: '932250959407',
    projectId: 'd-configurator-1731d',
    storageBucket: 'd-configurator-1731d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCL3AfPEaMnQbcuzBLIXiif0CKk4k3QgjE',
    appId: '1:932250959407:ios:b942aca427291995c010da',
    messagingSenderId: '932250959407',
    projectId: 'd-configurator-1731d',
    storageBucket: 'd-configurator-1731d.appspot.com',
    iosClientId: '932250959407-34do1bt8809db16f5j0t5vdbomev154d.apps.googleusercontent.com',
    iosBundleId: 'com.example.passwordManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCL3AfPEaMnQbcuzBLIXiif0CKk4k3QgjE',
    appId: '1:932250959407:ios:b942aca427291995c010da',
    messagingSenderId: '932250959407',
    projectId: 'd-configurator-1731d',
    storageBucket: 'd-configurator-1731d.appspot.com',
    iosClientId: '932250959407-34do1bt8809db16f5j0t5vdbomev154d.apps.googleusercontent.com',
    iosBundleId: 'com.example.passwordManager',
  );
}
