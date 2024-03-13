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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFWANVB5ulInPJqQT4zu-1fHURC_B1WdM',
    appId: '1:600804380370:android:dc489e6e0e2ebe80c7a70b',
    messagingSenderId: '600804380370',
    projectId: 'project-final-4beda',
    storageBucket: 'project-final-4beda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCp4URPWsKvFPExs4ff7iJk471e9llCZB4',
    appId: '1:600804380370:ios:1535741991b6cb79c7a70b',
    messagingSenderId: '600804380370',
    projectId: 'project-final-4beda',
    storageBucket: 'project-final-4beda.appspot.com',
    androidClientId: '600804380370-83mj4asvuooj1gkp4esfkeg878of5lk2.apps.googleusercontent.com',
    iosClientId: '600804380370-0ctt29e00son5nt563j572q8r6uqec0n.apps.googleusercontent.com',
    iosBundleId: 'com.flutterthailand.projectMobile',
  );
}
