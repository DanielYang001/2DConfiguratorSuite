import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as hooks;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/button/control_button_widget/control_button.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/control_buttons_section.dart';
import 'package:rt_10055_2D_configurator_suite/utils/size.dart';

class ControlButtonWidget extends StatefulHookConsumerWidget {
  final ControlButton button;
  final bool isSubButtons;
  const ControlButtonWidget(
      {super.key, required this.button, required this.isSubButtons});

  @override
  hooks.ConsumerState<hooks.ConsumerStatefulWidget> createState() =>
      _ControlButtonWidgetState();
}

class _ControlButtonWidgetState
    extends hooks.ConsumerState<ControlButtonWidget> {
  bool _horizantalIconsOpen = false;

  build(BuildContext context) {
    var currentIconColor = useState(Colors.white);
    double size =
        getDeviceHeight(context) * 0.035 + (widget.isSubButtons ? 10 : 0);
    return Padding(
      padding: widget.isSubButtons
          ? const EdgeInsets.only(left: 7)
          : const EdgeInsets.only(left: 15),
      child: MouseRegion(
        onEnter: (event) {
          currentIconColor.value = Colors.blue;
          if (widget.button.subButtons != null) {
            setState(() => _horizantalIconsOpen = true);
          }
        },
        onExit: (event) {
          currentIconColor.value = Colors.white;
          if (widget.button.subButtons != null) {
            setState(() => _horizantalIconsOpen = false);
          }
        },
        child: InkWell(
          onTap: widget.button.onPressed!,
          child: SizedBox(
              height: 60,
              // padding: EdgeInsets.only(
              //     top: widget.button.subButtons != null ? 30 : 0),
              child: Row(children: [
                GestureDetector(
                    child: Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: widget.button.image == null
                        ? Colors.transparent
                        : Colors.grey[300],
                    image: widget.button.image == null
                        ? null
                        : DecorationImage(
                            image: AssetImage(widget.button.image!),
                            fit: BoxFit.cover),
                  ),
                  child: Center(
                      child: widget.button.icon != null
                          ?
                          // Tooltip(
                          //         message: widget.button.title,
                          //         child:
                          Icon(
                              size: size,
                              widget.button.icon,
                              color: currentIconColor.value,
                              // ),
                            )
                          : const SizedBox()),
                )),
                if (widget.button.subButtons != null)
                  Visibility(
                      visible: _horizantalIconsOpen,
                      child: HorizontalControlButtonsSection(
                          isSubButtons: true,
                          buttons: [widget.button.subButtons!]))
              ])),
        ),
      ),
    );
  }
}
