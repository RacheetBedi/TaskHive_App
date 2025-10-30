import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/models/app_user.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/providers/google_auth_service_provider.dart';
import 'package:flutter_app/utilities/theme.dart';
import 'package:flutter_app/routing/wrapper.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AuthNotifier extends StateNotifier<AsyncValue<AppUser?>> {
  final Ref ref;
  StreamSubscription<User?>? _authSubscription;

  AuthNotifier(this.ref) : super(const AsyncValue.loading()) {
    _listenToAuthChanges();
  }

   void _listenToAuthChanges() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen(
      (User? firebaseUser) {
        if (firebaseUser != null) {
          state = AsyncValue.data(AppUser.fromFirebaseUser(firebaseUser));
        } else {
          state = const AsyncValue.data(null);
        }
      },
      onError: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );
  }

  Future<void> _loadCurrentUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      state = AsyncValue.data(AppUser.fromFirebaseUser(firebaseUser));
    } else {
      state = const AsyncValue.data(null);
    }
  }

  bool _isShowingNewUserDialog = false;
  bool get isShowingNewUserDialog => _isShowingNewUserDialog;


  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading(); 

    try {

      final authService = ref.read(GoogleAuthServiceProvider);
      final userCredential = await authService.signInWithGoogleFirebase();



      if (userCredential?.user != null) {
        final hasCompletedSetup = userCredential.additionalUserInfo?.isNewUser ?? false;
        if(hasCompletedSetup){
          _isShowingNewUserDialog = true;
        }


        final appUser = AppUser.fromFirebaseUser(
          userCredential!.user!,
          hasCompletedSetup: hasCompletedSetup);
        state = AsyncValue.data(appUser);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (error, st) {
      state = AsyncValue.error(error, st);
      // Get.snackbar(
      //   "Error",
      //   "Unexpected Google Sign-In Error: ${error.toString()}",
      //   duration: const Duration(seconds: 10),
      // );
    }
  }

  void clearNewUserDialogFlag(){
    _isShowingNewUserDialog = false;
  }

  Future<void> signOut() async {
    final authService = ref.read(GoogleAuthServiceProvider);
    await authService.signOut();
    state = const AsyncValue.data(null);
  }


  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        state = AsyncValue.data(AppUser.fromFirebaseUser(credential.user!));
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (error, st) {
      state = AsyncValue.error(error, st);
      Get.snackbar(
        "Error",
        "Email Sign-In Error: ${error.toString()}",
        duration: const Duration(seconds: 10),
      );
    }
  }
}


final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<AppUser?>>(
  (ref) => AuthNotifier(ref),
);






// final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn());

// final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(ref.read));

// class AuthRepository {
//   final Ref _ref; // Reader is a typedef shipped by Riverpod
//   AuthRepository(this._ref);

//   Future<UserCredential> signInWithGoogle() async {
//     final googleSignIn = _ref.watch(googleSignInProvider);
//     final firebaseAuth = _ref.watch(firebaseAuthProvider);

//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) throw Exception('User cancelled');

//     final googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     return firebaseAuth.signInWithCredential(credential);
//   }
// }



