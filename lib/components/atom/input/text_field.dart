import 'package:flutter/material.dart';

class CeerTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isObfuscated;
  final String? hint;
  final double? width;
  final double? height;
  final bool? isReadOnly;

  const CeerTextField({
    super.key,
    this.hint,
    this.width,
    this.height,
    this.isReadOnly,
    required this.controller,
    required this.focusNode,
    required this.isObfuscated,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        readOnly: isReadOnly ?? false,
        // style: headline5TextStyle,
        controller: controller,
        focusNode: focusNode,
        obscureText: isObfuscated,
        decoration: InputDecoration(
          hintText: hint,
          // hintStyle: buttonTextStyle1,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
