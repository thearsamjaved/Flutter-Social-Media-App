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
    apiKey: 'AIzaSyCKlHi_PWeBLhxWvYhP6QDIQ6g1-T5RQd4',
    appId: '1:137288861141:web:1877bcaf8d1e2670b1295c',
    messagingSenderId: '137288861141',
    projectId: 'arsam-fyp',
    authDomain: 'arsam-fyp.firebaseapp.com',
    storageBucket: 'arsam-fyp.appspot.com',
    measurementId: 'G-F9LPSV8DQ6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPtHeJlZG-vu9EYXGjq70vnQrhS8b_kEA',
    appId: '1:137288861141:android:b877c5d5925e854db1295c',
    messagingSenderId: '137288861141',
    projectId: 'arsam-fyp',
    storageBucket: 'arsam-fyp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXhnXh6FWoIOJgIR_OujwmjlKQUwLSGcw',
    appId: '1:137288861141:ios:2076a6cbc1d829c0b1295c',
    messagingSenderId: '137288861141',
    projectId: 'arsam-fyp',
    storageBucket: 'arsam-fyp.appspot.com',
    androidClientId: '137288861141-7buf78n3r5jdm7ufbfdj0sk5nrn5bmej.apps.googleusercontent.com',
    iosClientId: '137288861141-mtsqnmehs62it22o2hp12dilk7s4vams.apps.googleusercontent.com',
    iosBundleId: 'com.mikkyboy.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXhnXh6FWoIOJgIR_OujwmjlKQUwLSGcw',
    appId: '1:137288861141:ios:e25fd218e056fe06b1295c',
    messagingSenderId: '137288861141',
    projectId: 'arsam-fyp',
    storageBucket: 'arsam-fyp.appspot.com',
    androidClientId: '137288861141-7buf78n3r5jdm7ufbfdj0sk5nrn5bmej.apps.googleusercontent.com',
    iosBundleId: 'com.mikkyboy.socialMediaApp.RunnerTests',
  );
}