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
    apiKey: 'AIzaSyBWG5FN1F7V6CK7h8vcPNppiRgJB_apGBU',
    appId: '1:1095335432937:web:3e1f3df0dfd911269a1678',
    messagingSenderId: '1095335432937',
    projectId: 'fir-connectivity-f8bba',
    authDomain: 'fir-connectivity-f8bba.firebaseapp.com',
    storageBucket: 'fir-connectivity-f8bba.appspot.com',
    measurementId: 'G-ZH4W0GR97D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-fwDZtvfcAi-5DwAWJXvzHF6_nvrN9ow',
    appId: '1:1095335432937:android:2f987c5846884c0c9a1678',
    messagingSenderId: '1095335432937',
    projectId: 'fir-connectivity-f8bba',
    storageBucket: 'fir-connectivity-f8bba.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_V7NgZJt1GH5CIWqmKQLzMQHGaGTR2gY',
    appId: '1:1095335432937:ios:a222f337994d9fcc9a1678',
    messagingSenderId: '1095335432937',
    projectId: 'fir-connectivity-f8bba',
    storageBucket: 'fir-connectivity-f8bba.appspot.com',
    androidClientId: '1095335432937-utptv4vqbghi92h2ufasl70uhq4ob1m4.apps.googleusercontent.com',
    iosClientId: '1095335432937-5dmduj1olgqbfcdljvu7v6ug78jqmgtv.apps.googleusercontent.com',
    iosBundleId: 'com.example.todo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_V7NgZJt1GH5CIWqmKQLzMQHGaGTR2gY',
    appId: '1:1095335432937:ios:35fe0957f1fc3e719a1678',
    messagingSenderId: '1095335432937',
    projectId: 'fir-connectivity-f8bba',
    storageBucket: 'fir-connectivity-f8bba.appspot.com',
    androidClientId: '1095335432937-utptv4vqbghi92h2ufasl70uhq4ob1m4.apps.googleusercontent.com',
    iosClientId: '1095335432937-so7v46iqc8gp97gqpj9riv3eo05n0jrh.apps.googleusercontent.com',
    iosBundleId: 'com.example.todo.RunnerTests',
  );
}
