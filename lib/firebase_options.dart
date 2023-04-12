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
    apiKey: 'AIzaSyCRn-8ZYqQt5b_Ok9phcd3fbOItJ3KaSuI',
    appId: '1:440307373124:web:8fc5814538e1e6cee39811',
    messagingSenderId: '440307373124',
    projectId: 'agenda-nurse',
    authDomain: 'agenda-nurse.firebaseapp.com',
    databaseURL: 'https://agenda-nurse-default-rtdb.firebaseio.com',
    storageBucket: 'agenda-nurse.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGNVezXB67cGsWP7wKxPAXbX2nO-cNQIw',
    appId: '1:440307373124:android:4e294d0236a5a49ee39811',
    messagingSenderId: '440307373124',
    projectId: 'agenda-nurse',
    databaseURL: 'https://agenda-nurse-default-rtdb.firebaseio.com',
    storageBucket: 'agenda-nurse.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXdKokNStMlEk4wDzHiEXZTEObNLLVMcM',
    appId: '1:440307373124:ios:84aefd3f5b04339ee39811',
    messagingSenderId: '440307373124',
    projectId: 'agenda-nurse',
    databaseURL: 'https://agenda-nurse-default-rtdb.firebaseio.com',
    storageBucket: 'agenda-nurse.appspot.com',
    iosClientId: '440307373124-tpplan7jjp0ng736jg98pmbn7i2tmiag.apps.googleusercontent.com',
    iosBundleId: 'com.techtitans.agendanurse',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXdKokNStMlEk4wDzHiEXZTEObNLLVMcM',
    appId: '1:440307373124:ios:84aefd3f5b04339ee39811',
    messagingSenderId: '440307373124',
    projectId: 'agenda-nurse',
    databaseURL: 'https://agenda-nurse-default-rtdb.firebaseio.com',
    storageBucket: 'agenda-nurse.appspot.com',
    iosClientId: '440307373124-tpplan7jjp0ng736jg98pmbn7i2tmiag.apps.googleusercontent.com',
    iosBundleId: 'com.techtitans.agendanurse',
  );
}
