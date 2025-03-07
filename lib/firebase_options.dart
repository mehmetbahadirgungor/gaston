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
    apiKey: 'AIzaSyDXlJD7N87PXllPfIRzoM961oEVFsFgrTA',
    appId: '1:929606688665:web:56433151c01fffb7263d08',
    messagingSenderId: '929606688665',
    projectId: 'cab-ren-183b2',
    authDomain: 'cab-ren-183b2.firebaseapp.com',
    storageBucket: 'cab-ren-183b2.appspot.com',
    measurementId: 'G-8CDCF04R4N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtle70nRhuvguVnXvg0bGQMy6Fi3ai1PM',
    appId: '1:929606688665:android:eb6df52ae56893d5263d08',
    messagingSenderId: '929606688665',
    projectId: 'cab-ren-183b2',
    storageBucket: 'cab-ren-183b2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIwWL5wjfCmSbAhfR7A8nVPioZg35cxX4',
    appId: '1:929606688665:ios:6e369eb4d3601e6b263d08',
    messagingSenderId: '929606688665',
    projectId: 'cab-ren-183b2',
    storageBucket: 'cab-ren-183b2.appspot.com',
    iosClientId: '929606688665-urlh4rmqvqfrua28ohgoasc0rbj4e42a.apps.googleusercontent.com',
    iosBundleId: 'com.example.gaston',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIwWL5wjfCmSbAhfR7A8nVPioZg35cxX4',
    appId: '1:929606688665:ios:6e369eb4d3601e6b263d08',
    messagingSenderId: '929606688665',
    projectId: 'cab-ren-183b2',
    storageBucket: 'cab-ren-183b2.appspot.com',
    iosClientId: '929606688665-urlh4rmqvqfrua28ohgoasc0rbj4e42a.apps.googleusercontent.com',
    iosBundleId: 'com.example.gaston',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXlJD7N87PXllPfIRzoM961oEVFsFgrTA',
    appId: '1:929606688665:web:679aaa3784ee44e6263d08',
    messagingSenderId: '929606688665',
    projectId: 'cab-ren-183b2',
    authDomain: 'cab-ren-183b2.firebaseapp.com',
    storageBucket: 'cab-ren-183b2.appspot.com',
    measurementId: 'G-REGRW4D35Y',
  );
}
