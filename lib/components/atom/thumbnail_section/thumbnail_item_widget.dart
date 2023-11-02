import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/thumbnail_section/thumbnail_item_model.dart';
import 'package:rt_10055_2D_configurator_suite/theme/color.dart';
import 'package:rt_10055_2D_configurator_suite/theme/typography.dart';

class ThumbnailItemWidget extends HookConsumerWidget {
  final ({double height, double width}) size;
  final ThumbnailItemModel currentThumbnailItem;
  final bool isSelected;
  final void Function()? onTap;
  const ThumbnailItemWidget(
      {super.key,
      this.onTap,
      required this.size,
      required this.currentThumbnailItem,
      required this.isSelected});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        onTap!();
        currentThumbnailItem!.onTap!();
      },
      child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: isSelected ? textSelected : Colors.transparent,
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage(currentThumbnailItem.image)),
                      ),
                      // child: isSelected
                      //     ? const Align(
                      //         alignment: Alignment.topRight,
                      //         child: Icon(
                      //           Icons.check_circle,
                      //           color: textSelected,
                      //         ),
                      //       )
                      //     : const SizedBox(),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Opacity(
                opacity: currentThumbnailItem.title != null ? 1 : 0,
                child: Text(
                  textAlign: TextAlign.center,
                  currentThumbnailItem.title.toString(),
                  style: paragraphTextStyle,
                ),
              ),
              const SizedBox(height: 5),
              Opacity(
                opacity: currentThumbnailItem.price != null ? 1 : 0,
                child: Text(
                  textAlign: TextAlign.center,
                  currentThumbnailItem.price.toString(),
                  style: paragraphTextStyle,
                ),
              ),
            ],
          )),
    );
  }
}
