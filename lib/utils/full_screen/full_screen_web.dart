import 'dart:html';

void setFullScreen(bool isFullScreen) {
  if (isFullScreen) {
    document.documentElement!.requestFullscreen();
  } else {
    document.exitFullscreen();
  }
}
