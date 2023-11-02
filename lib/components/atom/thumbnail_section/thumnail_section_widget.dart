import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/thumbnail_section/thumbnail_item_model.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/thumbnail_section/thumbnail_item_widget.dart';
import 'package:rt_10055_2D_configurator_suite/theme/typography.dart';

class ThumbnailSection extends HookConsumerWidget {
  final String title;
  final List<ThumbnailItemModel> thumbnailItems;
  const ThumbnailSection(
      {super.key, required this.title, required this.thumbnailItems});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedIndex = useState(0);
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth * 0.2;
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          runSpacing: 4,
          spacing: 7,
          children: thumbnailItems
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: ThumbnailItemWidget(
                    onTap: () {
                      selectedIndex.value = thumbnailItems.indexOf(e);
                    },
                    size: (
                      height: size,
                      // (constraints.maxWidth / thumbnailItems.length).toDouble() * 0.8,
                      width: size
                    ),
                    currentThumbnailItem: e,
                    isSelected:
                        selectedIndex.value == thumbnailItems.indexOf(e),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
