import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;

class GoogleAuthService {
  late GoogleSignIn _googleSignIn;
  late FirebaseAuth _firebaseAuth;
  bool _isGoogleSignInInitialized = false;
  GoogleSignInAccount? _currentUser;

  GoogleAuthService([FirebaseAuth? firebaseAuth]) {
    _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
    _googleSignIn = GoogleSignIn.instance;
    _initializeGoogleSignIn();
  }

  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      if (!_isGoogleSignInInitialized) {
        await _googleSignIn.initialize();
        _isGoogleSignInInitialized = true;
      }
    } catch (e) {
      print("Google Sign In Error: $e");
      Get.snackbar(
        "Error",
        "Could not initialize Google Sign In: ${e.toString()}",
        duration: const Duration(seconds: 10),
      );
    }
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  GoogleSignInAccount? get currentUser => _currentUser;
  bool get isSignedIn => _currentUser != null;

  Future<void> signOutGoogle() async {
    try {
  
      await _ensureGoogleSignInInitialized();
      
      await _googleSignIn.signOut();
      
      await _firebaseAuth.signOut();
      
      _currentUser = null;
      
    } catch (error) {
      print("Sign out error: $error");
      Get.snackbar(
        "Error",
        "Google Sign out failed: ${error.toString()}",
        duration: const Duration(seconds: 10),
      );
      rethrow;
    }
  }

  Future<void> signOutNative() async{
    try {
      
      await _firebaseAuth.signOut();
      
      _currentUser = null;
      
    } catch (error) {
      print("Native Sign out error: $error");
      Get.snackbar(
        "Error",
        "Native Sign out failed: ${error.toString()}",
        duration: const Duration(seconds: 10),
      );
    }
  }

  Future<UserCredential> signInWithGoogleFirebase() async {
    await _ensureGoogleSignInInitialized();

    try {
      
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        return userCredential;
      } else {
        final googleUser = await _googleSignIn.authenticate();
        if (googleUser == null) {
          throw Exception("Google sign-in aborted");
        }


        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        final userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        _currentUser = googleUser;
        
        return userCredential;
      }
    } catch (error) {
      Get.snackbar(
        "Error",
        "Unexpected Google Sign-In Error: ${error.toString()}",
        duration: const Duration(seconds: 10),
      );
      rethrow;
    }
  }

  Future<GoogleSignInAccount> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized();

    try {
      final GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );
      return account;
    } on GoogleSignInException catch (e) {
      print("Google Sign In Error: $e");
      Get.snackbar(
        "Error",
        "Google Sign In Error: ${e.toString()}",
        duration: const Duration(seconds: 10),
      );
      rethrow;
    } catch (error) {
      print("Google Sign In Error: $error");
      Get.snackbar(
        "Error",
        "Unexpected Google Sign-In Error: ${error.toString()}",
        duration: const Duration(seconds: 10),
      );
      rethrow;
    }
  }

  Future<GoogleSignInAccount?> attemptsSilentSignIn() async {
    await _ensureGoogleSignInInitialized();

    try {
      final result = _googleSignIn.attemptLightweightAuthentication();

      if (result is Future<GoogleSignInAccount?>) {
        return await result;
      } else {
        return result as GoogleSignInAccount?;
      }
    } catch (error) {
      print("Silent sign-in error: $error");
      Get.snackbar(
        "Error",
        "Silent sign-in failed: ${error.toString()}",
        duration: const Duration(seconds: 10),
      );
      return null;
    }
  }
}