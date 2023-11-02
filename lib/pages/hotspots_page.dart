import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as hooks;
import 'package:provider/provider.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/imageview360.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/hotspots/hotspots.dart';
import 'package:rt_10055_2D_configurator_suite/components/templates/main_template.dart';
import 'package:rt_10055_2D_configurator_suite/mockup_content/images_names_mapping.dart';
import 'package:rt_10055_2D_configurator_suite/stores/ConfigStore.dart';
import 'package:rt_10055_2D_configurator_suite/stores/HotspotsStore.dart';
import 'package:rt_10055_2D_configurator_suite/utils/null_checker.dart';
import 'package:rt_10055_2D_configurator_suite/utils/query_param_utils.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

final WidgetsToImageController _imageConvertController =
    WidgetsToImageController();

class HotspotsPage extends hooks.StatefulHookConsumerWidget {
  final Map<String, int>? queryParamConfig;

  const HotspotsPage({super.key, required this.queryParamConfig});

  @override
  hooks.ConsumerState<hooks.ConsumerStatefulWidget> createState() =>
      _HotspotsPageState();
}

class _HotspotsPageState extends hooks.ConsumerState<HotspotsPage> {
  Object? _logoData;
  int? _currentImageIndex = 0;
  final String _assetsPath = '';
  final bool _fromLocalDevice = false;
  String _hotspotName = '';
  HotspotsController hotspotsController = HotspotsController();

  @override
  void initState() {
    super.initState();
    initializeStore();
  }

  @override
  void didUpdateWidget(covariant HotspotsPage oldWidget) {
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
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    var store = Provider.of<ConfigStore>(context);
    var hsStore = Provider.of<HotspotsStore>(context);

    Map<String, dynamic> hotspots = hsStore.hotspots();

    return Scaffold(
        body: GestureDetector(
            onTap: () => hotspotsController.showHideOptions(false),
            child: MainTemplate(
              headerWidget: Container(),
              sideMenuWidget: LayoutBuilder(builder: (context, constraints) {
                return sideMenu(
                    hsStore, constraints.maxHeight, constraints.maxWidth);
              }),
              mainViewWidget:
                  Stack(alignment: AlignmentDirectional.topStart, children: [
                LayoutBuilder(builder: (context, constraints) {
                  return Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        ImageView360(
                          allowSwipeToRotate: false,
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
                          hotspotsController: hotspotsController,
                          hotspotsEditMode: true,
                          fromLocalDevice: _fromLocalDevice,
                          assetsPath: _assetsPath,
                        ),
                        // Stack(
                        //   children: hotspots.entries
                        //       .map((e) => hotspotPoint(hsStore, e.key))
                        //       .toList(),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            changeFrameButtonLeft(hsStore),
                            changeFrameButtonRight(hsStore),
                          ],
                        ),
                      ]);
                })
              ]),
              bottomBarWidget: bottomBarWidget(),
            )));
  }

  Widget changeFrameButtonLeft(HotspotsStore hsStore) {
    Map<String, dynamic> hotspots = hsStore.hotspots();
    String activeHotspotId = hsStore.activeHotspotId();

    dynamic activeHotspotPosition_ = hotspots?[activeHotspotId]
        ?['offsetsOnFrames']?[_currentImageIndex]['offset'];
    Offset? activeHotspotPosition__;
    if (activeHotspotPosition_ != null) {
      activeHotspotPosition__ =
          Offset(activeHotspotPosition_['x'], activeHotspotPosition_['y']);
    }
    Offset activeHotspotPosition =
        activeHotspotPosition__ ?? const Offset(0, 0);
    const Offset(0, 0);
    return ElevatedButton(
        onPressed: () {
          hsStore.updateHotspotPosition(
              activeHotspotId, _currentImageIndex!, activeHotspotPosition);
          _currentImageIndex == 0
              ? setState(() => _currentImageIndex = 69)
              : setState(() => _currentImageIndex = _currentImageIndex! - 1);
        },
        child: const Icon(Icons.arrow_back_ios));
  }

  Widget changeFrameButtonRight(HotspotsStore hsStore) {
    Map<String, dynamic> hotspots = hsStore.hotspots();
    String activeHotspotId = hsStore.activeHotspotId();
    dynamic activeHotspotPosition_ = hotspots?[activeHotspotId]
        ?['offsetsOnFrames']?[_currentImageIndex]['offset'];
    Offset? activeHotspotPosition__;
    if (activeHotspotPosition_ != null) {
      activeHotspotPosition__ =
          Offset(activeHotspotPosition_['x'], activeHotspotPosition_['y']);
    }
    Offset activeHotspotPosition =
        activeHotspotPosition__ ?? const Offset(0, 0);
    return ElevatedButton(
        onPressed: () {
          hsStore.updateHotspotPosition(
              activeHotspotId, _currentImageIndex!, activeHotspotPosition);
          _currentImageIndex == 69
              ? setState(() => _currentImageIndex = 0)
              : setState(() => _currentImageIndex = _currentImageIndex! + 1);
        },
        child: const Icon(Icons.arrow_forward_ios));
  }

  Widget bottomBarWidget() {
    return Container();
  }

  Widget sideMenu(HotspotsStore hsStore, double height, double width) {
    return SizedBox(
        height: height,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...[
                      const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Hotspots:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                      if (hsStore.hotspots().isEmpty)
                        const Text(
                          'No hotspots added',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        )
                    ],
                    ...hsStore
                        .hotspots()
                        .entries
                        .toList()
                        .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () => hsStore.setActive(e.key),
                                      child: Text(
                                        e.value['name'],
                                        style: TextStyle(
                                            color: hsStore.hotspots()[e.key]
                                                    ['active']
                                                ? Colors.blue
                                                : Colors.black),
                                      )),
                                  Wrap(spacing: 5, children: [
                                    InkWell(
                                        onTap: () =>
                                            editHotspotDialog(hsStore, e.key),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 14,
                                        )),
                                    InkWell(
                                        onTap: () =>
                                            deleteHotspotDialog(hsStore, e.key),
                                        child: const Icon(
                                          Icons.delete,
                                          size: 14,
                                        ))
                                  ])
                                ])))
                        .toList()
                  ],
                ),
                Column(children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: SizedBox(
                          width: width,
                          child: FilledButton(
                              onPressed: () => addNewHotspotDialog(hsStore),
                              child: const Text('Add a new hotspot')))),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: SizedBox(
                          width: width,
                          child: FilledButton(
                              onPressed: () => print(hsStore.hotspots()),
                              child: const Text('Print JSON'))))
                ])
              ],
            )));
  }

  void deleteHotspotDialog(HotspotsStore hsStore, String hotspotId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            child: Container(
                width: 250,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Are you sure you want to delete [${hsStore.hotspots()[hotspotId]['name']}]',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    const Text(
                        'By deleting this hotspot, info of the positions assigned within the hotspot will be lost too',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    const SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 115,
                              child: FilledButton(
                                  onPressed: () {
                                    hsStore.deleteHotspot(hotspotId);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(fontSize: 15),
                                  ))),
                          SizedBox(
                              width: 115,
                              child: FilledButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 15),
                                  )))
                        ])
                  ],
                )),
          );
        });
  }

  void editHotspotDialog(HotspotsStore hsStore, String hotspotId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Edit hotspot [${hsStore.hotspots()[hotspotId]['name']}] info',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: 250,
                        child: TextField(
                            onChanged: (String val) =>
                                hotspotsController.editHotspotName(val),
                            decoration: const InputDecoration(
                                hintText: 'Hotspot name',
                                hintStyle: TextStyle(fontSize: 15)))),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: 250,
                        child: FilledButton(
                            onPressed: () {
                              hsStore.editHotspot(
                                  hotspotId, hotspotsController.hotspotName);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Edit Hotspot',
                              style: TextStyle(fontSize: 15),
                            )))
                  ],
                )),
          );
        });
  }

  void addNewHotspotDialog(HotspotsStore hsStore) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Create a new hotspot',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: 250,
                        child: TextField(
                            onChanged: (String val) =>
                                setState(() => _hotspotName = val),
                            decoration: const InputDecoration(
                                hintText: 'Hotspot name',
                                hintStyle: TextStyle(fontSize: 15)))),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: 250,
                        child: FilledButton(
                            onPressed: () {
                              hsStore.addHotspot(
                                  _hotspotName, _currentImageIndex!);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Add Hotspot',
                              style: TextStyle(fontSize: 15),
                            )))
                  ],
                )),
          );
        });
  }

  Widget controlButtonsSection() {
    return Container();
  }
}
