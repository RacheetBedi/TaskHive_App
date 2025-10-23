import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/forgot.dart';
import 'package:flutter_app/signup.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;

class googleAuthService{
  var _googleSignIn = GoogleSignIn.instance;
  var _firebaseAuth = FirebaseAuth.instance;
  bool _isGoogleSignInInitialized = false;

  googleAuthService(FirebaseAuth firebase_auth){
    this._firebaseAuth = firebase_auth;
    
    _initializeGoogleSignIn();
  }

  Stream<User?> authStateChanges(){
    return _firebaseAuth.authStateChanges();
  }

  Future<void> _initializeGoogleSignIn() async {
  try {
    await _googleSignIn.initialize();
    _isGoogleSignInInitialized = true;
    
  } catch (e) {
    print("Google Sign In Error: $e"); // For debugging
    Get.snackbar(
      "Error", 
      "Could not initialize Google Sign In: ${e.toString()}",
      duration: Duration(seconds: 10),
      );
    }
  }

  Future<void> _ensureGoogleSignInInitialized() async{
    if(!_isGoogleSignInInitialized){
      await _initializeGoogleSignIn();
    }
  }

  Future<GoogleSignInAccount> signInWithGoogle() async{
    await _ensureGoogleSignInInitialized();

    try{
      final GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );
      return account;
    } on GoogleSignInException catch(e){
      print("Google Sign In Error: $e"); // For debugging
      Get.snackbar(
      "Error", 
      "Google Sign In Error: ${e.toString()}",
      duration: Duration(seconds: 10),
      );
      rethrow;
    } catch (error){
      print("Google Sign In Error: $error"); // For debugging
      Get.snackbar(
      "Error", 
      "Unexpected Google Sign-In Error: ${error.toString()}",
      duration: Duration(seconds: 10),
      );
      rethrow;
    }
  }

  Future<GoogleSignInAccount?> attemptsSilentSignIn() async{
    await _ensureGoogleSignInInitialized();

    try{
      final result = _googleSignIn.attemptLightweightAuthentication();

      if(result is Future<GoogleSignInAccount?>){
        return await result;
      } else{
        return result as GoogleSignInAccount?;
      }
    } catch(error){
      print("Google Sign In Error: $error"); // For debugging
      Get.snackbar(
      "Error", 
      "Silent sign-in failed: ${error.toString()}",
      duration: Duration(seconds: 10),
      );
      return null;
    }
  }

  GoogleSignInAuthentication getAuthTokens(GoogleSignInAccount account){
    return account.authentication;
  }

  Future<String?> getAccessTokenforScopes(List<String> scopes) async{
    await _ensureGoogleSignInInitialized();

    try{
      final authClient = _googleSignIn.authorizationClient;

      var authorization = await authClient.authorizationForScopes(scopes);

      if(authorization == null){
        authorization = await authClient.authorizeScopes(scopes);
      }

      return authorization.accessToken;

    } catch(error){
      print("Failed to get access token for scopes: $error"); // For debugging
      Get.snackbar(
      "Error", 
      "Failed to get access token for scopes: ${error.toString()}",
      duration: Duration(seconds: 10),
      );
      return null;
    }
  }

  GoogleSignInAccount? _currentUser;
  GoogleSignInAccount? get currentUser => _currentUser;

  bool get isSignedIn => _currentUser != null;

  Future<void> signIn() async{
    try{
      _currentUser = await signInWithGoogle();
      _notifyUserChanged();
    } catch (error){
      _currentUser = null;
      rethrow;
    }
  }

  Future<void> signOut() async{
    await _googleSignIn.signOut();
    _currentUser = null;
    _notifyUserChanged();
  }

  Future<UserCredential> signInWithGoogleFirebase() async{
    await _ensureGoogleSignInInitialized();

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    final authClient = _googleSignIn.authorizationClient;
    final authorization = await authClient.authorizationForScopes(['email']);

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    _currentUser = googleUser;

    return userCredential;
  }

}