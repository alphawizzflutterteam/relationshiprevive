import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;

      default:
        return android;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkvK05yuexsLuSWy9B91DJwi_wimt6Xxo',
    appId: '1:884911350693:android:4ba0b2de65baa504823e4c',
    messagingSenderId: '884911350693',
    projectId: 'realtionship-849b1',
    storageBucket: 'realtionship-849b1.firebasestorage.app',
  );

  

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkvK05yuexsLuSWy9B91DJwi_wimt6Xxo',
    appId: '1:884911350693:android:4ba0b2de65baa504823e4c',
    messagingSenderId: '884911350693',
    projectId: 'realtionship-849b1',
    storageBucket: 'realtionship-849b1.firebasestorage.app',
    iosBundleId: 'com.os.AstroGuru.app',
  );

}