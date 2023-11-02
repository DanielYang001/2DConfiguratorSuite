import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rt_10055_2D_configurator_suite/utils/agora_configs.dart'
    as config;

class TokenNotifier extends StateNotifier<String?> {
  TokenNotifier(super.state);

  Future<void> fetchToken(int uid, String channelName, int tokenRole) async {
    // Prepare the Url
    String url =
        '${config.serverURL}/rtc/$channelName/${tokenRole.toString()}/uid/${uid.toString()}?expiry=${config.tokenExpireTime.toString()}';

    // Send the request
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      Map<String, dynamic> json = jsonDecode(response.body);
      String newToken = json['rtcToken'];
      print('Token Received: $newToken');
      state = newToken;
      // Use the token to join a channel or renew an expiring token
    } else {
      // If the server did not return an OK response,
      // then throw an exception.
      throw Exception(
          'Failed to fetch a token. Make sure that your server URL is valid');
    }
  }
}

final tokenNotifierProvider = StateNotifierProvider((ref) {
  return TokenNotifier(null);
});
