import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/selection_block/selection_block.dart';

class SelectionBlockSection extends HookConsumerWidget {
  final List<SelectionBlock> selectionBlocks;
  const SelectionBlockSection({super.key, required this.selectionBlocks});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedIndex = useState(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: selectionBlocks
          .map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: e,
              ))
          .toList(),
    );
  }
}
