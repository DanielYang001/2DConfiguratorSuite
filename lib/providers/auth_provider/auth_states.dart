import 'package:rt_10055_2D_configurator_suite/models/user_model.dart';

class AuthStates {
  const AuthStates();
}

class AuthInitialState extends AuthStates {
  const AuthInitialState();
}

class AuthLoadingState extends AuthStates {
  const AuthLoadingState();
}

class AuthSuccessState extends AuthStates {
  final UserModel? user;
  const AuthSuccessState({required this.user});
}

class AuthErrorState extends AuthStates {
  final String errorMessage;
  const AuthErrorState(this.errorMessage);
}
