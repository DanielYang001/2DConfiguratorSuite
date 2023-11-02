export '';
import 'package:flutter/material.dart';
import 'package:rt_10055_2D_configurator_suite/utils/size.dart';

import '../../components/atom/button/control_button_widget/control_button_widget.dart';

extension FlexDividerExtension on Flex {
  Widget addDividerToLast(
      {required bool isLast,
      required bool isHorizontal,
      required BuildContext context,
      required bool isEmpty,
      double? height,
      double? width}) {
    return isHorizontal
        ? Row(
            children: [
              this,
              isLast
                  ? SizedBox(
                      width: width ?? getDeviceHeight(context) * 0.05,
                      height: height ?? getDeviceHeight(context) * 0.05,
                      child: const Divider())
                  : const SizedBox()
            ],
          )
        : Column(
            children: [
              this,
              isLast
                  ? isEmpty
                      ? SizedBox(
                          height: height ?? getDeviceHeight(context) * 0.02,
                        )
                      : SizedBox(
                          width: width ?? getDeviceHeight(context) * 0.05,
                          child: const Divider())
                  : const SizedBox()
            ],
          );
  }

  Widget addDividerToEach(
      {required bool isLast,
      required BuildContext context,
      bool isPaddedBottom = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      this,
      isLast
          ? const SizedBox()
          : SizedBox(
              height: 10,
              width: getDeviceWidth(context),
              child: const Divider(),
            ),
      isPaddedBottom
          ? const SizedBox(
              height: 15,
            )
          : const SizedBox()
    ]);
  }
}

extension ControlDividerExtension on ControlButtonWidget {
  Widget addDivider(bool isNotLast, bool isHorizontal, BuildContext context) {
    return isHorizontal
        ? Row(
            children: [
              this,
              isNotLast
                  ? SizedBox(
                      height: getDeviceHeight(context) * 0.05,
                      child: const Divider())
                  : const SizedBox()
            ],
          )
        : Column(
            children: [
              this,
              isNotLast
                  ? SizedBox(
                      width: getDeviceHeight(context) * 0.05,
                      child: const Divider())
                  : const SizedBox()
            ],
          );
  }
}
