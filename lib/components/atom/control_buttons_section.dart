import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/button/control_button_widget/control_button_widget.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/button/control_button_widget/control_button.dart';
import 'package:rt_10055_2D_configurator_suite/utils/extensions/divider_extension.dart';

class ControlButtonsSection extends HookConsumerWidget {
  final List<List<ControlButton>> buttons;
  final bool isSubButtons;
  const ControlButtonsSection(
      {super.key, required this.buttons, required this.isSubButtons});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        children: buttons.map((e) {
      int currentIndex = buttons.indexOf(e);
      return Column(
        children: [
          Container(
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Column(
              children: e.map((e) {
                int currentButtonIndex = buttons[currentIndex].indexOf(e);
                return ControlButtonWidget(
                  button: e,
                  isSubButtons: isSubButtons,
                  // ).addDivider(
                  //     currentButtonIndex + 1 != buttons[currentIndex].length,
                  //     false,
                  //     context);
                );
              }).toList(),
            ),
          ),
        ],
        // ).addDividerToLast(
        //     isLast: currentIndex + 1 != buttons.length,
        //     isHorizontal: false,
        //     context: context,
        //     isEmpty: true);
      );
    }).toList());
  }
}

class HorizontalControlButtonsSection extends HookConsumerWidget {
  final List<List<ControlButton>> buttons;
  final bool isSubButtons;
  const HorizontalControlButtonsSection(
      {super.key, required this.buttons, required this.isSubButtons});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: buttons.map((e) {
                int currentIndex = buttons.indexOf(e);
                return Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        children: e.map((e) {
                          int currentButtonIndex =
                              buttons[currentIndex].indexOf(e);
                          return ControlButtonWidget(
                            button: e,
                            isSubButtons: isSubButtons,
                          ).addDivider(
                              currentButtonIndex + 1 !=
                                  buttons[currentIndex].length,
                              true,
                              context);
                        }).toList(),
                      ),
                    ),
                  ],
                ).addDividerToLast(
                    isLast: currentIndex + 1 != buttons.length,
                    isHorizontal: true,
                    context: context,
                    isEmpty: false);
              }).toList(),
            ),
          ],
        ));
  }
}
