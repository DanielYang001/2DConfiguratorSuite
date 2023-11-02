import 'package:flutter/material.dart';

class RoundedBtn extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final double? width;
  final double? height;
  final bool isDisabled;
  const RoundedBtn(
      {super.key,
      this.isDisabled = false,
      this.onTap,
      required this.text,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? () {} : onTap,
      child: Container(
        width: width ?? 200,
        height: height ?? 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            // style: buttonTextStyle1,
          ),
        ),
      ),
    );
  }
}
