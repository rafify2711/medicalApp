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
    apiKey: 'AIzaSyAfFgMaKYwY3q_xW1u8t6HjvlehqtNzezk',
    appId: '1:170948620311:web:db2386be454d63d87bac52',
    messagingSenderId: '170948620311',
    projectId: 'medicalapp-191e1',
    authDomain: 'medicalapp-191e1.firebaseapp.com',
    storageBucket: 'medicalapp-191e1.firebasestorage.app',
    measurementId: 'G-H3T86W9118',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgeVZQvf1D71YPX8jRXfCD35iWYeIatTI',
    appId: '1:170948620311:android:5d53dc4005ceeb5e7bac52',
    messagingSenderId: '170948620311',
    projectId: 'medicalapp-191e1',
    storageBucket: 'medicalapp-191e1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKvoJT5vugL472pv8w-ju0RfaKrIh74pw',
    appId: '1:170948620311:ios:b0ff5b2cf53629277bac52',
    messagingSenderId: '170948620311',
    projectId: 'medicalapp-191e1',
    storageBucket: 'medicalapp-191e1.firebasestorage.app',
    iosBundleId: 'com.example.graduationMedicalApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKvoJT5vugL472pv8w-ju0RfaKrIh74pw',
    appId: '1:170948620311:ios:b0ff5b2cf53629277bac52',
    messagingSenderId: '170948620311',
    projectId: 'medicalapp-191e1',
    storageBucket: 'medicalapp-191e1.firebasestorage.app',
    iosBundleId: 'com.example.graduationMedicalApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAfFgMaKYwY3q_xW1u8t6HjvlehqtNzezk',
    appId: '1:170948620311:web:699a08f18d59a5cc7bac52',
    messagingSenderId: '170948620311',
    projectId: 'medicalapp-191e1',
    authDomain: 'medicalapp-191e1.firebaseapp.com',
    storageBucket: 'medicalapp-191e1.firebasestorage.app',
    measurementId: 'G-CRZL3R2157',
  );
}
