import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/selection_block/selection_block.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/selection_block/selection_block_model.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/thumbnail_section/thumbnail_item_model.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/thumbnail_section/thumnail_section_widget.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/side_menu_item.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/side_menu_section.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/subsection_item.dart';
import 'package:rt_10055_2D_configurator_suite/utils/size.dart';

class TrySelectionBlockWidget extends HookConsumerWidget {
  const TrySelectionBlockWidget({super.key});
  static const routeName = '/trySelectionWidget';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedIndex = useState(0);
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 500,
                color: Colors.white,
                child: SideMenuSection(onClick: (String s) {}, sideMenuItems: [
                  SideMenuItem(
                      title: "Versions",
                      subtitle: "Choose your model",
                      subsectionItems: [
                        SubsectionItem(
                            title: "Color",
                            widget: ThumbnailSection(
                                title: "Color",
                                thumbnailItems: [
                                  ThumbnailItemModel(
                                    image: "assets/icons/facebook.png",
                                    title: null,
                                    price: null,
                                  ),
                                  ThumbnailItemModel(
                                    image: "assets/icons/twitter.png",
                                    title: "Blue",
                                    price: 150,
                                  ),
                                  ThumbnailItemModel(
                                    image: "assets/icons/linkedin.png",
                                    title: "Green",
                                    price: 200,
                                  ),
                                ])),
                        SubsectionItem(
                            title: "Material",
                            widget: ThumbnailSection(
                                title: "Color",
                                thumbnailItems: [
                                  ThumbnailItemModel(
                                    image: "assets/icons/facebook.png",
                                    title: null,
                                    price: null,
                                  ),
                                  ThumbnailItemModel(
                                    image: "assets/icons/twitter.png",
                                    title: "Blue",
                                    price: 150,
                                  ),
                                  ThumbnailItemModel(
                                    image: "assets/icons/linkedin.png",
                                    title: "Green",
                                    price: 200,
                                  ),
                                ]))
                      ]),
                  SideMenuItem(
                      title: "Versions",
                      subtitle: "Choose your model",
                      subsectionItems: [
                        SubsectionItem(
                            title: "Color",
                            widget: ThumbnailSection(
                                title: "Color",
                                thumbnailItems: [
                                  ThumbnailItemModel(
                                    image: "assets/icons/facebook.png",
                                    title: null,
                                    price: null,
                                  ),
                                  ThumbnailItemModel(
                                    image: "assets/icons/twitter.png",
                                    title: "Blue",
                                    price: 150,
                                  ),
                                  ThumbnailItemModel(
                                    image: "assets/icons/linkedin.png",
                                    title: "Green",
                                    price: 200,
                                  ),
                                ])),
                        SubsectionItem(
                            title: "Material",
                            widget: ThumbnailSection(
                                title: "Color",
                                thumbnailItems: [
                                  ThumbnailItemModel(
                                    image: "assets/icons/facebook.png",
                                    title: null,
                                    price: null,
                                  ),
                                  ThumbnailItemModel(
                                    image: "assets/icons/twitter.png",
                                    title: "Blue",
                                    price: 150,
                                  ),
                                  ThumbnailItemModel(
                                    image: "assets/icons/linkedin.png",
                                    title: "Green",
                                    price: 200,
                                  ),
                                ]))
                      ]),
                ]),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  color: Colors.white,
                  width: 500,
                  child: ThumbnailSection(title: "Color", thumbnailItems: [
                    ThumbnailItemModel(
                      image: "assets/icons/facebook.png",
                      title: null,
                      price: null,
                    ),
                    ThumbnailItemModel(
                      image: "assets/icons/twitter.png",
                      title: "Blue",
                      price: 150,
                    ),
                    ThumbnailItemModel(
                      image: "assets/icons/linkedin.png",
                      title: "Green",
                      price: 200,
                    ),
                  ])),
              SizedBox(
                width: getDeviceWidth(context) * 0.5,
                child: SelectionBlock(
                  readMoreTitle: "Details",
                  onTap: () {
                    selectedIndex.value = 0;
                  },
                  isSelected: selectedIndex.value == 0,
                  currentSelectionBlock: SelectionBlockModel(
                      title: "T10X V1 RWD Standart Menzil",
                      description: "314 km Menzil 160 kW Arkadan itişli",
                      price: "1.227.500",
                      details: "T10X V1 RWD Standart Menzil"),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: getDeviceWidth(context) * 0.5,
                child: SelectionBlock(
                  readMoreTitle: "Details",
                  onTap: () {
                    selectedIndex.value = 1;
                  },
                  isSelected: selectedIndex.value == 1,
                  currentSelectionBlock: SelectionBlockModel(
                      title: "2T10X V1 RWD Standart Menzil",
                      description: "2314 km Menzil 160 kW Arkadan itişli",
                      price: "21.227.500",
                      details: "2T10X V1 RWD Standart Menzil"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
