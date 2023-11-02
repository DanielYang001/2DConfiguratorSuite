import 'dart:developer';

import 'package:rt_10055_2D_configurator_suite/data_services/auth_repository.dart';
import 'package:rt_10055_2D_configurator_suite/models/user_model.dart';

import 'package:rt_10055_2D_configurator_suite/providers/auth_provider/auth_states.dart';
import 'package:rt_10055_2D_configurator_suite/utils/readable_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/providers/auth_provider/auth_states.dart';

import 'auth_events.dart';

class AuthStateController extends StateNotifier<AuthStates> {
  AuthStateController() : super(const AuthInitialState());

  AuthRepository _authRepository = AuthRepository();

  Future mapEventsToStates(AuthEvents authEvents) async {
    return authEvents.map(
      loginWithEmail: (LoginWithEmail event) async {
        state = const AuthLoadingState();
        try {
          UserModel? user =
              await _authRepository.loginWithEmail(event.email, event.password);

          state = AuthSuccessState(user: user);
        } catch (e) {
          log(e.toString());
          if (e is FirebaseException) {
            log(e.code);
            log(e.message!);

            state = AuthErrorState(readableErrorMessage(e.code));
          } else {
            state = AuthErrorState(readableErrorMessage('unexpected_error'));
          }
        }
      },
      signUpWithemail: (SignUpWithEmail event) async {
        state = const AuthLoadingState();
        try {
          UserModel? user = await _authRepository.registerWithEmail(
              event.nickname, event.password);
          if (user != null) {
            state = AuthSuccessState(user: user);
          } else {
            state = AuthErrorState(readableErrorMessage('unexpected_error'));
          }
        } catch (e) {
          if (e is FirebaseException) {
            state = AuthErrorState(readableErrorMessage(e.code));
          } else {
            state = AuthErrorState(readableErrorMessage('unexpected_error'));
          }
        }
      },
      socialAuth: (SocialAuth event) async {
        state = const AuthLoadingState();
        try {
          UserModel? user = await _authRepository.socialAuth(event.type);
          if (user != null) {
            state = AuthSuccessState(user: user);
          } else {
            state = AuthErrorState(readableErrorMessage('unexpected_error'));
          }
        } catch (e) {
          if (e is FirebaseException) {
            state = AuthErrorState(readableErrorMessage(e.code));
          } else {
            state = AuthErrorState(readableErrorMessage('unexpected_error'));
          }
        }
      },
    );
  }
}

final authProvider = StateNotifierProvider<AuthStateController, AuthStates>(
    (ref) => AuthStateController());
