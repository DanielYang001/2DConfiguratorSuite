import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rt_10055_2D_configurator_suite/models/user_model.dart';
import 'package:rt_10055_2D_configurator_suite/providers/auth_provider/auth_events.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthApiClient {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> loginWithEmail(String email, String password) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    if (credential.user != null) {
      log('loginWithNickname' + credential.user!.uid + 'done ');
      return UserModel(
        uid: credential.user!.uid,
      );
    } else {
      log('loginWithNickname' + 'failed ');
      return null;
    }
  }

  Future<UserModel?> registerWithEmail(String email, String password) async {
    UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    if (credential.user != null) {
      log('registerWithNickname' + credential.user!.uid + 'done ');
      return UserModel(
        uid: credential.user!.uid,
      );
    } else {
      log('registerWithNickname' + 'failed ');
      return null;
    }
  }

  Future<UserModel?> authCheck() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      log('authCheck' + user.uid + 'done ');
      return UserModel(
        uid: user.uid,
      );
    } else {
      log('authCheck' + 'not logged in ');
      return null;
    }
  }

  Future<UserModel?> socialAuth(SocialAuthType type) async {
    UserCredential? credential;
    if (type == SocialAuthType.google) {
      credential = await signInWithGoogle();
      if (credential != null && credential.user != null) {
        log('socialAuth' + credential.user!.uid + 'done ');
        return UserModel(
          uid: credential.user!.uid,
        );
      } else {
        log('socialAuth' + 'failed ');
        return null;
      }
    } else if (type == SocialAuthType.apple) {
      credential = await signInWithApple();
      if (credential != null && credential.user != null) {
        log('socialAuth' + credential.user!.uid + 'done ');
        return UserModel(
          uid: credential.user!.uid,
        );
      } else {
        log('socialAuth' + 'failed ');
        return null;
      }
    } else {
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    UserCredential? credential;

    if (kIsWeb) {
      final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      googleAuthProvider.addScope('email');
      googleAuthProvider.addScope('profile');
      credential =
          await FirebaseAuth.instance.signInWithPopup(googleAuthProvider);
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      credential =
          await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
    }

    return credential;
  }

  Future<UserCredential?> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    OAuthCredential credential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    UserCredential? userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential;
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential?> signInWithMicrosoft() async {
    final microsoftProvider = MicrosoftAuthProvider();
    if (kIsWeb) {
      return await FirebaseAuth.instance.signInWithPopup(microsoftProvider);
    } else {
      return await FirebaseAuth.instance.signInWithProvider(microsoftProvider);
    }
  }
}

String generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = math.Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
