/// Get your own App ID at https://dashboard.agora.io/
String get appId {
  // Allow pass an `appId` as an environment variable with name `TEST_APP_ID` by using --dart-define
  return "4d32236c4fec475089a345e833702473";
}

/// Please refer to https://docs.agora.io/en/Agora%20Platform/token
String get token {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  return "007eJxTYHi+c68fh6jFjOV3Hq7LNWSPPFZzzEabQ5I1upHRZmvhtkAFBpMUYyMjY7Nkk7TUZBNzUwMLy0RjE9NUC2NjcwMjE3Pjz7OvpDQEMjIIKy5iYmSAQBCfgyG5tLgkPze1iIEBABF6Hlk=";
}

/// Your channel ID
String get channelId {
  // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
  return "customer";
}

String get serverURL {
  // Allow pass a `serverURL` as an environment variable with name `TEST_SERVER_URL` by using --dart-define
  return "https://testestes.test";
}

int get tokenExpireTime {
  return 45;
}

/// Your int user ID
const int uid = 0;

/// Your user ID for the screen sharing
const int screenSharingUid = 10;

/// Your string user ID
const String stringUid = '0';

String get musicCenterAppId {
  // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
  return const String.fromEnvironment('MUSIC_CENTER_APPID',
      defaultValue: '<MUSIC_CENTER_APPID>');
}
