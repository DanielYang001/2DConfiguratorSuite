import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/control_buttons_section.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/button/control_button_widget/control_button.dart';

class TryWidget extends HookConsumerWidget {
  const TryWidget({super.key});
  static String name = "/tryWidget";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ControlButtonsSection(
              isSubButtons: false,
              buttons: [
                [
                  ControlButton(onPressed: () {}, icon: Icons.add),
                  ControlButton(
                    onPressed: () {},
                    icon: Icons.read_more,
                    subButtons: [
                      ControlButton(
                          onPressed: () {},
                          image:
                              "assets/output_jpegs/01.01.00.00.00.00.00.00.00.00.07.png"),
                      ControlButton(
                          onPressed: () {},
                          image:
                              "assets/output_jpegs/01.01.00.00.00.00.00.00.00.00.00.png"),
                    ],
                  ),
                ],
                [
                  ControlButton(onPressed: () {}, icon: Icons.add),
                  ControlButton(onPressed: () {}, icon: Icons.read_more),
                  ControlButton(
                      onPressed: () {},
                      icon: Icons.kebab_dining,
                      subButtons: [
                        ControlButton(onPressed: () {}, icon: Icons.add),
                        ControlButton(onPressed: () {}, icon: Icons.read_more),
                        ControlButton(onPressed: () {}, icon: Icons.add),
                        ControlButton(
                            onPressed: () {},
                            image:
                                "assets/output_jpegs/01.01.00.00.00.00.00.00.00.00.09.png"),
                      ]),
                  ControlButton(onPressed: () {}, icon: Icons.kayaking)
                ],
                [
                  ControlButton(onPressed: () {}, icon: Icons.add),
                  ControlButton(
                    onPressed: () {},
                    icon: Icons.read_more,
                    subButtons: [
                      ControlButton(
                          onPressed: () {},
                          image:
                              "assets/output_jpegs/01.01.00.00.00.00.00.00.00.00.07.png"),
                      ControlButton(
                          onPressed: () {},
                          image:
                              "assets/output_jpegs/01.01.00.00.00.00.00.00.00.00.00.png"),
                    ],
                  ),
                ],
                [
                  ControlButton(
                    onPressed: () {},
                    icon: Icons.add,
                    subButtons: [
                      ControlButton(
                          onPressed: () {},
                          image:
                              "assets/output_jpegs/01.01.00.00.00.00.00.00.00.00.07.png"),
                      ControlButton(
                          onPressed: () {},
                          image:
                              "assets/output_jpegs/01.01.00.00.00.00.00.00.00.00.00.png"),
                    ],
                  ),
                ],
              ],
            )
          ],
        ),
      ),
    );
  }
}
