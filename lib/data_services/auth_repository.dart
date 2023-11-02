import 'package:rt_10055_2D_configurator_suite/data_services/auth_api_client.dart';
import 'package:rt_10055_2D_configurator_suite/models/user_model.dart';
import 'package:rt_10055_2D_configurator_suite/providers/auth_provider/auth_events.dart';

class AuthRepository {
  final AuthApiClient _authApi = AuthApiClient();

  Future<UserModel?> loginWithEmail(String nickname, String password) async {
    return await _authApi.loginWithEmail(nickname, password);
  }

  Future<UserModel?> registerWithEmail(String nickname, String password) async {
    return await _authApi.registerWithEmail(nickname, password);
  }

  Future<UserModel?> authCheck() async {
    return await _authApi.authCheck();
  }

  Future<UserModel?> socialAuth(SocialAuthType type) async {
    return await _authApi.socialAuth(type);
  }
}
