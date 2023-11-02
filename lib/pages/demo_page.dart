import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as hooks;
import 'package:provider/provider.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/button/bottom_bar_button.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/button/control_button_widget/control_button.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/control_buttons_section.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/imageview360.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/interior_view.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/selection_block/selection_block.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/selection_block/selection_block_model.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/hotspots/hotspots.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/main_header.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/thumbnail_section/thumbnail_item_model.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/thumbnail_section/thumnail_section_widget.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/side_menu_item.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/side_menu_section.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/subsection_item.dart';
import 'package:rt_10055_2D_configurator_suite/components/templates/main_template.dart';
import 'package:rt_10055_2D_configurator_suite/enums/general_enums.dart';
import 'package:rt_10055_2D_configurator_suite/mockup_content/images_names_mapping.dart';
import 'package:rt_10055_2D_configurator_suite/stores/ConfigStore.dart';
import 'package:rt_10055_2D_configurator_suite/stores/HotspotsStore.dart';
import 'package:rt_10055_2D_configurator_suite/utils/null_checker.dart';
import 'package:rt_10055_2D_configurator_suite/utils/query_param_utils.dart';
import 'package:rt_10055_2D_configurator_suite/utils/size.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:rt_10055_2D_configurator_suite/utils/full_screen/full_screen.dart';
import 'dart:js' as js;

class DemoPage extends hooks.StatefulHookConsumerWidget {
  final Map<String, int>? queryParamConfig;

  const DemoPage({super.key, required this.queryParamConfig});

  @override
  hooks.ConsumerState<hooks.ConsumerStatefulWidget> createState() =>
      _DemoPageState();
}

class _DemoPageState extends hooks.ConsumerState<DemoPage> {
  final WidgetsToImageController _imageConvertController =
      WidgetsToImageController();
  ConfiguratorView? _configuratorView = ConfiguratorView.exterior;
  Object? _logoData;
  int? _currentImageIndex = 0;
  String _assetsPath = '';
  final bool _fromLocalDevice = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    initializeStore();
  }

  @override
  void didUpdateWidget(covariant DemoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (mapIsNotEmpty(widget.queryParamConfig!) &&
        !isConfigsIdentical(
            oldConfig: oldWidget.queryParamConfig,
            newConfig: widget.queryParamConfig!)) {
      initializeStore();
    }
  }

  void initializeStore() {
    Provider.of<ConfigStore>(context, listen: false)
        .initializeStore(imagesMapping, widget.queryParamConfig!);
    Provider.of<HotspotsStore>(context, listen: false).initializeStore();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    var store = Provider.of<ConfigStore>(context);

    return Scaffold(
        body: MainTemplate(
      headerWidget: MainHeader(
        loggedIn: false,
        onLogoTap: () {},
        onAccountTap: () {},
        onLogoutTap: () {},
        accountImage: '',
      ),
      sideMenuWidget: sideMenu(store),
      mainViewWidget: mainViewWidget(store),
      // Stack(
      //     alignment: AlignmentDirectional.topStart,
      //     children: [
      //       Align(
      //           alignment: AlignmentDirectional.topStart,
      //           child: controlButtonsSection())
      //     ]),
      bottomBarWidget: bottomBarWidget(store.configurations),
      fullScreen: _isFullScreen,
    ));
  }

  Widget mainViewWidget(ConfigStore store) {
    var hsStore = Provider.of<HotspotsStore>(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return _configuratorView == ConfiguratorView.exterior
          ? Stack(alignment: AlignmentDirectional.topStart, children: [
              ImageView360(
                imageConvertController: _imageConvertController,
                key: UniqueKey(),
                width: constraints.maxWidth,
                frames: 70,
                imagesMapping: store.variablesImages,
                logoData: _logoData,
                defaultImageIndex: _currentImageIndex,
                onImageIndexChanged: (int? crntImgIndx) {
                  _currentImageIndex = crntImgIndx;
                },
                hsStore: hsStore,
                hotspotsEditMode: false,
                hotspotsController: HotspotsController(),
                fromLocalDevice: _fromLocalDevice,
                assetsPath: _assetsPath,
              ),
              // Hotspots(
              //   editMode: false,
              //   hsStore: hsStore,
              //   currentImageIndex: _currentImageIndex!,
              //   hotspotsController: HotspotsController(),
              // ),
              leftIcons(store)
            ])
          : Align(
              alignment: AlignmentDirectional.topStart, child: HtmlWidget('''
          <iframe height="${constraints.maxHeight}" allowfullscreen style="border-style:none;" src="https://cdn.pannellum.org/2.5/pannellum.htm#panorama=https://2d-configurator-test.s3.eu-west-2.amazonaws.com/interior/${store.interiorImage}&amp;autoLoad=true"></iframe>
          '''));

      // InteriorView(
      //         image: Image.asset(
      //           height: 400,
      //           'assets/interior/${store.interiorImage}',
      //         ),
      //       );
    });
  }

  Widget leftIcons(ConfigStore store) {
    List<ControlButton> bkgButtons = [];

    final environmentValues =
        imagesMapping['Environment']['values'] as Map<String, dynamic>;

    environmentValues.forEach((key, value) {
      bkgButtons.add(ControlButton(
          image: value['image'],
          onPressed: () => store.onPressConfig('Environment', value)));
    });

    return ControlButtonsSection(isSubButtons: false, buttons: [
      [
        ControlButton(
            onPressed: () {
              setState(() => _isFullScreen = !_isFullScreen);
            },
            icon: Icons.fullscreen,
            title: 'Full Screen'),
        ControlButton(
          onPressed: () {},
          icon: Icons.image,
          title: 'Change Background',
          subButtons: bkgButtons,
        ),
        // ControlButton(
        //     onPressed: () {}, icon: Icons.contrast, title: 'Day And Night'),
        ControlButton(onPressed: () {}, icon: Icons.toll, title: 'Hotspot'),
      ]
    ]);
  }

  Widget bottomBarWidget(Map<String, int> configurations) {
    return Container(
        color: Colors.white,
        child: Row(
          children: [
            BottomBarButton(
              title: 'CAR NAME',
              onPressed: () {},
            ),
            BottomBarButton(
              title: 'CAR INFO',
              onPressed: () {},
            ),
            BottomBarButton(
              title: 'CAR INFO',
              onPressed: () {},
            ),
            Expanded(child: Container()),
            if (getDeviceWidth(context) > 500)
              BottomBarButton(
                  icon: Icons.share,
                  title: 'SHARE',
                  onPressed: () => onPressShareLink(configurations, context)),
            if (getDeviceWidth(context) > 700)
              BottomBarButton(
                icon: Icons.contact_mail,
                title: 'CONTACT US',
                onPressed: () {},
              ),
            if (getDeviceWidth(context) > 900)
              BottomBarButton(
                  icon: Icons.summarize, title: 'SUMMARY', onPressed: () {})
          ],
        ));
  }

  Map<String, List<Map<dynamic, dynamic>>> formMenuMapping() {
    Map<String, List<Map<dynamic, dynamic>>> imagesMappingMenus = {};
    imagesMapping.forEach((key, value) {
      if (value['menu'] != null) {
        List<Map<dynamic, dynamic>> existingMenu =
            imagesMappingMenus[value['menu']] ?? [];
        imagesMappingMenus[value['menu']] = [
          ...existingMenu,
          ...[value]
        ];
      }
    });
    return imagesMappingMenus;
  }

  sideMenu(ConfigStore store) {
    Map<String, List<Map<dynamic, dynamic>>> imagesMappingMenus =
        formMenuMapping();
    List<SideMenuItem> sideMenuItems = [];
    imagesMappingMenus.forEach((key, value) {
      List<SubsectionItem>? subsectionItems = [];
      for (var value_ in value) {
        if (value_['display_as'] != null) {
          List<Widget> selectionWidgets = [];
          if (value_['display_as'] == 'block_selection') {
            value_['values'].forEach((key__, value__) {
              selectionWidgets.add(SelectionBlock(
                isSelected:
                    store.configurations[value_['key']] == value__['value'],
                onTap: () => store.onPressConfig(value_['key'], value__),
                readMoreTitle: "Read More",
                currentSelectionBlock: SelectionBlockModel(
                  title: value__['name'],
                  description: value__['description'] ?? "",
                  details: 'a',
                  price: value__['cost'].toString(),
                ),
              ));
            });
          }
          if (value_['display_as'] == 'thumbnail_selection') {
            List<ThumbnailItemModel> thumbnailItemModels = [];
            value_['values'].forEach((key__, value__) {
              thumbnailItemModels.add(ThumbnailItemModel(
                  onTap: () => {store.onPressConfig(value_['key'], value__)},
                  title: value__['name'],
                  image: value__['image'],
                  price: value__['cost']));
            });
            selectionWidgets.add(ThumbnailSection(
                title: "Thumbnail name", thumbnailItems: thumbnailItemModels));
          }
          subsectionItems.add(SubsectionItem(
              title: value_['name'],
              widget:
                  Wrap(spacing: 5, runSpacing: 5, children: selectionWidgets)));
        }
      }
      sideMenuItems.add(SideMenuItem(
          title: key, subtitle: null, subsectionItems: subsectionItems));
    });
    return SingleChildScrollView(
        child: SideMenuSection(
      sideMenuItems: sideMenuItems,
      onClick: (String key) {
        if (key == 'INTERIOR') {
          setState(() => _configuratorView = ConfiguratorView.interior);
          // js.context.callMethod('embedPanoramaView', ['hmmm']);
        } else {
          setState(() => _configuratorView = ConfiguratorView.exterior);
        }
      },
    ));
  }

  Widget controlButtonsSection() {
    return ControlButtonsSection(
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
          ControlButton(onPressed: () {}, icon: Icons.minimize),
        ],
      ],
    );
  }
}
