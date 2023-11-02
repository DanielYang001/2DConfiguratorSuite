import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/theme/typography.dart';
import 'package:rt_10055_2D_configurator_suite/utils/size.dart';

class BottomBarButton extends HookConsumerWidget {
  String title;
  IconData? icon;
  bool isLoading;
  final void Function()? onPressed;

  BottomBarButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.icon,
      this.isLoading = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        onTap: onPressed,
        child: Container(
            padding: getDeviceWidth(context) < 1200
                ? const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
                : getDeviceWidth(context) < 1400
                    ? const EdgeInsets.symmetric(vertical: 20, horizontal: 20)
                    : const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Row(
              children: [
                if (icon != null && !isLoading) Icon(icon),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  isLoading ? 'Loading..' : title,
                  style: headline6TextStyle,
                )
              ],
            )));
  }
}
