import 'package:flutter/material.dart';

String screenSize() {
  double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  if (screenWidth >= 1200) {
    return 'lg';
  } else if (screenWidth >= 992) {
    return 'md';
  } else {
    return 'sm';
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
