import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/login_page.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_app/wrapper.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn());

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(ref.read));

class AuthRepository {
  final Ref _ref; // Reader is a typedef shipped by Riverpod
  AuthRepository(this._ref);

  Future<UserCredential> signInWithGoogle() async {
    final googleSignIn = _ref.watch(googleSignInProvider);
    final firebaseAuth = _ref.watch(firebaseAuthProvider);

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception('User cancelled');

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return firebaseAuth.signInWithCredential(credential);
  }
}



