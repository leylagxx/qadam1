import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Firebase configuration and initialization
class FirebaseConfig {
  static FirebaseAuth? _auth;
  static FirebaseFirestore? _firestore;

  /// Initialize Firebase
  static Future<void> initialize() async {
    if (kIsWeb) {
      // For web, Firebase is initialized via JavaScript
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCzNDow91EcEvcYxHEwnkpALNNPh78Hq7s",
          authDomain: "qadam-1.firebaseapp.com",
          projectId: "qadam-1",
          storageBucket: "qadam-1.firebasestorage.app",
          messagingSenderId: "683744111915",
          appId: "1:683744111915:web:d49a69d27d4f8e3954296e",
        ),
      );
    } else {
      // For mobile platforms
      await Firebase.initializeApp();
    }
    
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instanceFor(
      app: Firebase.app(),
      databaseId: 'qadam',
    );
  }

  /// Get Firebase Auth instance
  static FirebaseAuth get auth {
    if (_auth == null) {
      throw Exception('Firebase not initialized. Call initialize() first.');
    }
    return _auth!;
  }

  /// Get Firestore instance
  static FirebaseFirestore get firestore {
    if (_firestore == null) {
      throw Exception('Firebase not initialized. Call initialize() first.');
    }
    return _firestore!;
  }

  /// Check if user is authenticated
  static bool get isAuthenticated => auth.currentUser != null;

  /// Get current user
  static User? get currentUser => auth.currentUser;

  /// Sign out user
  static Future<void> signOut() async {
    await auth.signOut();
  }
}
