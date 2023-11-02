import 'package:flutter/services.dart';

void setFullScreen(bool isFullScreen) {
  if (isFullScreen) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  } else {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
}
