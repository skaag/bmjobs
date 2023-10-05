import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDGw_jMHHlj2jDGX0YGa0v7bjgOGjCdWE0",
            authDomain: "bmjobsorg.firebaseapp.com",
            projectId: "bmjobsorg",
            storageBucket: "bmjobsorg.appspot.com",
            messagingSenderId: "206930330626",
            appId: "1:206930330626:web:e8686b3884cbd979f5d31b",
            measurementId: "G-1HV58J2Y10"));
  } else {
    await Firebase.initializeApp();
  }
}
