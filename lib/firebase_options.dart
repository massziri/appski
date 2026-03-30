import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return web;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC361mySCZuFLiw3E_RPSYyrK975svNTnw',
    appId: '1:878970763246:web:fa1e451aa5acb3f3e340ff',
    messagingSenderId: '878970763246',
    projectId: 'appski-549ec',
    authDomain: 'appski-549ec.firebaseapp.com',
    storageBucket: 'appski-549ec.firebasestorage.app',
    measurementId: 'G-Y7W1S26VD7',
  );
}
