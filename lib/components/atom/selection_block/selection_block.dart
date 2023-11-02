import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/selection_block/selection_block_model.dart';
import 'package:rt_10055_2D_configurator_suite/theme/color.dart';
import 'package:rt_10055_2D_configurator_suite/theme/typography.dart';

class SelectionBlock extends HookConsumerWidget {
  final bool isSelected;
  final SelectionBlockModel currentSelectionBlock;
  final void Function()? onTap;
  final String readMoreTitle;
  const SelectionBlock(
      {super.key,
      required this.isSelected,
      this.onTap,
      required this.readMoreTitle,
      required this.currentSelectionBlock});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isOnHover = useState(false);
    return MouseRegion(
      onEnter: (event) {
        isOnHover.value = true;
      },
      onExit: (event) {
        isOnHover.value = false;
      },
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: (isSelected || isOnHover.value)
                      ? textSelected
                      : Colors.grey)),
          duration: const Duration(milliseconds: 100),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentSelectionBlock.title,
                  style: headline6BoldTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      currentSelectionBlock.description,
                      style: headline6TextStyle,
                    ),
                    const Spacer(),
                    Center(
                      child: Icon(
                        isSelected
                            ? Icons.check_circle_outline
                            : Icons.circle_outlined,
                        color: textSelected,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text("Details"),
                                content: Text(currentSelectionBlock.details),
                              );
                            });
                      },
                      child: Row(
                        children: [
                          Text(
                            readMoreTitle,
                            style: paragraphTextStyle,
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: textPrimary,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      currentSelectionBlock.price,
                      style: headline5TextStyle,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
