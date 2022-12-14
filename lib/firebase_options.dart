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
    apiKey: 'AIzaSyB_-JNwdYsmkcXtHMdZ_hU_a5XDZPS23LA',
    appId: '1:890255899975:web:40c7e35e664b8787d16062',
    messagingSenderId: '890255899975',
    projectId: 'waytofit-32c87',
    authDomain: 'waytofit-32c87.firebaseapp.com',
    storageBucket: 'waytofit-32c87.appspot.com',
    measurementId: 'G-ZRZ0X3F79N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeMkdorBYIMVs6iV-nK7YtBIfuTdBPbQ4',
    appId: '1:890255899975:android:d6a0acef9885bd7ed16062',
    messagingSenderId: '890255899975',
    projectId: 'waytofit-32c87',
    storageBucket: 'waytofit-32c87.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCl4vLlHR3_XQWJUdCZ0v1NU3WDcIXraPo',
    appId: '1:890255899975:ios:7224f9a1cc9e1c6cd16062',
    messagingSenderId: '890255899975',
    projectId: 'waytofit-32c87',
    storageBucket: 'waytofit-32c87.appspot.com',
    iosClientId: '890255899975-dnt1uvb62q0kkujp87fqkrjn8tjds1nr.apps.googleusercontent.com',
    iosBundleId: 'com.waytofit.wayToFit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCl4vLlHR3_XQWJUdCZ0v1NU3WDcIXraPo',
    appId: '1:890255899975:ios:7224f9a1cc9e1c6cd16062',
    messagingSenderId: '890255899975',
    projectId: 'waytofit-32c87',
    storageBucket: 'waytofit-32c87.appspot.com',
    iosClientId: '890255899975-dnt1uvb62q0kkujp87fqkrjn8tjds1nr.apps.googleusercontent.com',
    iosBundleId: 'com.waytofit.wayToFit',
  );
}
