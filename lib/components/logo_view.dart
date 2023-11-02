import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LogoView extends StatelessWidget {
  LogoView(
      {super.key,
      required this.logoPosition,
      required this.logoSize,
      required this.cornerWidth,
      required this.logoData,
      required this.select,
      required this.skew,
      required this.visible});

  double cornerWidth;
  Size logoSize;
  Offset logoPosition;
  String logoData;
  bool select;
  double skew;
  bool visible;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: logoPosition.dx,
          top: logoPosition.dy,
          child: Container(
            decoration: select
                ? BoxDecoration(border: Border.all(color: Colors.blueAccent))
                : const BoxDecoration(),
            child: Stack(children: [
              if (visible)
                Transform(
                    transform: Matrix4.skew(0, skew),
                    child: kIsWeb
                        ? Image.network(
                            logoData,
                            width: logoSize.width,
                            height: logoSize.height,
                          )
                        : Image.file(
                            File(logoData),
                            width: logoSize.width,
                            height: logoSize.height,
                          )),
              if (select)
                Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: cornerWidth,
                      height: cornerWidth,
                      decoration: const BoxDecoration(color: Colors.blueAccent),
                    )),
              if (select)
                Positioned(
                  left: 0,
                  top: logoSize.height - cornerWidth,
                  child: Container(
                    width: cornerWidth,
                    height: cornerWidth,
                    decoration: const BoxDecoration(color: Colors.blueAccent),
                  ),
                ),
              if (select)
                Positioned(
                  left: logoSize.width - cornerWidth,
                  top: logoSize.height - cornerWidth,
                  child: Container(
                    width: cornerWidth,
                    height: cornerWidth,
                    decoration: const BoxDecoration(color: Colors.blueAccent),
                  ),
                ),
              if (select)
                Positioned(
                  left: logoSize.width - cornerWidth,
                  top: 0,
                  child: Container(
                    width: cornerWidth,
                    height: cornerWidth,
                    decoration: const BoxDecoration(color: Colors.blueAccent),
                  ),
                ),
              if (select)
                Positioned(
                    right: cornerWidth,
                    top: cornerWidth,
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Colors.lightBlue,
                        child: Icon(
                          Icons.close,
                          color: Colors.blueAccent,
                          size: 20,
                        ),
                      ),
                    )),
            ]),
          ),
        ),
      ],
    );
  }
}
