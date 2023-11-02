import 'package:flutter/material.dart';

class ControlButton {
  final IconData? icon;
  final String? image;
  final String? title;
  final void Function()? onPressed;
  final List<ControlButton>? subButtons;

  ControlButton({
    this.icon,
    this.image,
    this.title,
    this.subButtons,
    required this.onPressed,
  });
}
