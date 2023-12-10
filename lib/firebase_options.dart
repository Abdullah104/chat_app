// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBz896Fx4WMedD-G2rozaKaBTHzEeaRKAs',
    appId: '1:167778331253:android:0034a6c15315aaf750263c',
    messagingSenderId: '167778331253',
    projectId: 'chat-app-2d94a',
    storageBucket: 'chat-app-2d94a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvJw39O1HkAJdxQM5O8IYCiLm4ebJJS3U',
    appId: '1:167778331253:ios:11a42fa329ab7b3250263c',
    messagingSenderId: '167778331253',
    projectId: 'chat-app-2d94a',
    storageBucket: 'chat-app-2d94a.appspot.com',
    iosClientId: '167778331253-1frj2j55bru9rhfjk6q2gk059cvkg67m.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
