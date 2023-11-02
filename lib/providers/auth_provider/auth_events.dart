import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_events.freezed.dart';

enum SocialAuthType { google, apple }

@freezed
class AuthEvents with _$AuthEvents {
  const factory AuthEvents.loginWithEmail(
      {required String email, required String password}) = LoginWithEmail;
  const factory AuthEvents.signUpWithemail(
      {required String nickname, required String password}) = SignUpWithEmail;
  const factory AuthEvents.socialAuth({required SocialAuthType type}) =
      SocialAuth;
}
