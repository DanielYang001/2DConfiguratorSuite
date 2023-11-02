import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as hooks;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/generate_pdf_button/generate_pdf_button.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/imageview360.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/interior_view.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/selection_block/selection_block.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/selection_block/selection_block_model.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/thumbnail_section/thumbnail_item_model.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/thumbnail_section/thumnail_section_widget.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/hotspots/hotspots.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/side_menu_item.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/side_menu_section.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/subsection_item.dart';
import 'package:rt_10055_2D_configurator_suite/enums/general_enums.dart';
import 'package:rt_10055_2D_configurator_suite/mockup_content/images_names_mapping.dart';
import 'package:rt_10055_2D_configurator_suite/mockup_content/packages_map.dart';
import 'package:rt_10055_2D_configurator_suite/mockup_content/pre_defined_frames.dart';
import 'package:rt_10055_2D_configurator_suite/models/packages.dart';
import 'package:rt_10055_2D_configurator_suite/pages/login_page.dart';
import 'package:rt_10055_2D_configurator_suite/pages/signup_page.dart';
import 'package:rt_10055_2D_configurator_suite/pages/try_widget.dart';
import 'package:rt_10055_2D_configurator_suite/pages/video_call_page.dart';
import 'package:rt_10055_2D_configurator_suite/providers/database_provider/database_provider.dart';
import 'package:rt_10055_2D_configurator_suite/stores/ConfigStore.dart';
import 'package:rt_10055_2D_configurator_suite/stores/HotspotsStore.dart';
import 'package:rt_10055_2D_configurator_suite/utils/full_screen/full_screen.dart';
import 'package:rt_10055_2D_configurator_suite/utils/null_checker.dart';
import 'package:rt_10055_2D_configurator_suite/utils/query_param_utils.dart';
import 'package:rt_10055_2D_configurator_suite/utils/size.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../utils/util_explorer/util_explorer.dart';

final WidgetsToImageController _imageConvertController =
    WidgetsToImageController();

class HomePage extends hooks.StatefulHookConsumerWidget {
  final Map<String, int>? queryParamConfig;
  const HomePage({super.key, required this.queryParamConfig});

  @override
  hooks.ConsumerState<hooks.ConsumerStatefulWidget> createState() =>
      _HomePageState();
}

class _HomePageState extends hooks.ConsumerState<HomePage> {
  Object? _logoData;
  int? _currentImageIndex;
  int _dropdownIndex = 0;
  ConfiguratorView? _configuratorView = ConfiguratorView.exterior;
  String _assetsPath = '';
  final bool _fromLocalDevice = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    initializeStore();
    setAssetsPath();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
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

  void setAssetsPath() async {
    if (!kIsWeb && Platform.isAndroid && _fromLocalDevice) {
      _assetsPath = (await getExternalStorageDirectory())!.path;
    }
  }

  bool isListening = false;

  startListenChanges(ConfigStore store) {
    var dbProvider = ref.read(databaseProvider.notifier);

    if (!isListening) {
      isListening = true;
      store.addListener(() {
        dbProvider.saveChanges(
            config: store.configurations,
            package: store.selectedPackage,
            totalCost: store.totalCost,
            cost: store.cost);
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    var store = Provider.of<ConfigStore>(context);
    startListenChanges(store);

    return Scaffold(
        body: SizedBox(
      height: getDeviceHeight(context),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: !_isFullScreen
                    ? getDeviceHeight(context) * 0.8
                    : getDeviceHeight(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mapIsNotEmpty(store.configurations)
                        ? Expanded(child:
                            LayoutBuilder(builder: (context, constraints) {
                            return Stack(
                              children: [
                                Center(
                                    child: Container(
                                  color: Colors.white,
                                  width: constraints.maxWidth - 300,
                                  child: _configuratorView ==
                                          ConfiguratorView.exterior
                                      ? ImageView360(
                                          imageConvertController:
                                              _imageConvertController,
                                          key: UniqueKey(),
                                          width: constraints.maxWidth - 300,
                                          frames: 70,
                                          imagesMapping: store.variablesImages,
                                          logoData: _logoData,
                                          defaultImageIndex: _currentImageIndex,
                                          onImageIndexChanged:
                                              (int? crntImgIndx) {
                                            _currentImageIndex = crntImgIndx;
                                          },
                                          fromLocalDevice: _fromLocalDevice,
                                          assetsPath: _assetsPath,
                                          hsStore: HotspotsStore(70),
                                          hotspotsEditMode: false,
                                          hotspotsController:
                                              HotspotsController(),
                                        )
                                      : InteriorView(
                                          image: Image(
                                              width: constraints.maxWidth - 300,
                                              image: NetworkImage(
                                                  'https://2d-configurator-test.s3.eu-west-2.amazonaws.com/interior/${store.interiorImage}'))),
                                )),
                                Positioned(
                                  right: 12,
                                  bottom: 12,
                                  child: GestureDetector(
                                      onTap: () {
                                        _isFullScreen = !_isFullScreen;
                                        setFullScreen(_isFullScreen);
                                        setState(() {});
                                      },
                                      child: Icon(
                                        _isFullScreen
                                            ? Icons.fullscreen_exit
                                            : Icons.fullscreen,
                                        size: 32,
                                        color: Colors.blueAccent,
                                      )),
                                ),
                              ],
                            );
                          }))
                        : const CircularProgressIndicator(),
                    Container(height: 10),

                    if (!_isFullScreen) Text('Total Cost: ${store.totalCost}'),
                    if (!_isFullScreen) Container(height: 10),
                    // Text(widget.queryParamConfig.toString()),
                    if (!_isFullScreen) const Text("Packages:"),
                    if (!_isFullScreen) packagesWidget(store),

                    if (!_isFullScreen)
                      Wrap(spacing: 7, children: [
                        if (mapIsNotEmpty(store.savedConfigurations))
                          loadPrevConfigsBtn(store),
                        shareLinkButton(store.configurations),
                        generatePDFButton(
                            store.totalCost, store.configurations),
                        uploadLogoButton(),
                        configuratorViewSwitcher(),
                        loginButton(),
                        signupButton(),
                        preDefinedViewButton(),
                        checkOutButton(store),
                        customerSupportButton(),
                        selectionWidgetTry()
                      ]),
                  ],
                ),
              ),
              if (!_isFullScreen)
                Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: changeConfigsButtons(store)),
              if (!_isFullScreen)
                Container(
                  width: getDeviceWidth(context) * 0.4,
                  child: sideMenuWidgets(store),
                ),
            ]),
      ),
    ));
  }

  checkOutButton(ConfigStore store) {
    return ElevatedButton(
        onPressed: () async {
          setState(() {
            _currentImageIndex = 11;
          });
          var dbProvider = ref.read(databaseProvider.notifier);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.deepOrange,
              content: Text("Loading"),
            ),
          );

          bool isSaved = await dbProvider
              .saveCurrentConfigImages(store.getImageVariable());
        },
        child: Text("Checkout"));
  }

  packagesWidget(ConfigStore store) {
    List<Package> packages = Packages.fromMap(packagesMock).packages!;

    return SizedBox(
      height: getDeviceHeight(context) * 0.17,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: packages.length,
        itemBuilder: (context, index) {
          Package currentPackage = packages[index];
          return GestureDetector(
            onTap: () {
              store.changeSelectedPackage(currentPackage);
            },
            child: SizedBox(
              width: 200,
              child: Card(
                color: store.selectedPackage?.id == currentPackage.id
                    ? Colors.blueAccent
                    : Colors.white,
                child: Column(
                  children: [
                    Text(currentPackage.name!),
                    Text(currentPackage.description!),
                    Text(currentPackage.price.toString()),
                    InkWell(
                      child: const Text("Details"),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: getDeviceHeight(context) * 0.3,
                                  width: getDeviceWidth(context) * 0.3,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: currentPackage.details!.length,
                                    itemBuilder: (context, index) {
                                      return Text(
                                        "•" + currentPackage.details![index],
                                      );
                                    },
                                  ),
                                ),
                              );
                            });
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget generatePDFButton(double totalCost, Map<String, int> configurations) {
    return GeneratePDFButton(
      totalCost: totalCost,
      printConfigurations: configurations,
      configMapping: imagesMapping,
      imageConvertcontroller: _imageConvertController,
      loadingStyle:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey)),
      loadingChild: const Text('Loading..'),
      child: const Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 7,
          children: [Text('Summary Generator'), Icon(Icons.download)]),
    );
  }

  Widget shareLinkButton(Map<String, int> configurations) {
    return ElevatedButton(
        onPressed: () => onPressShareLink(configurations, context),
        child: const Text('Share Link'));
  }

  Widget loadPrevConfigsBtn(ConfigStore store) {
    return ElevatedButton(
      onPressed: () => store.loadSavedConfigs(),
      child: const Text('Load Previous Configurations'),
    );
  }

  Widget uploadLogoButton() {
    return ElevatedButton(
      onPressed: () async {
        _logoData = await openFileExplorer();
        setState(() {});
      },
      child: const Text('Select Logo'),
    );
  }

  Widget customerSupportButton() {
    return ElevatedButton(
        onPressed: () {
          // context.go(VideoCallPage.name);
        },
        child: const Text('Customer Support'));
  }

  Widget selectionWidgetTry() {
    return ElevatedButton(
        onPressed: () {
          context.go(TrySelectionBlockWidget.routeName);
        },
        child: const Text('Selection Widget'));
  }

  Widget loginButton() {
    return ElevatedButton(
        onPressed: () {
          context.go(LoginPage.name);
        },
        child: const Text('Login'));
  }

  Widget signupButton() {
    return ElevatedButton(
        onPressed: () {
          context.go(SignupPage.name);
        },
        child: const Text('Signup'));
  }

  Widget preDefinedViewButton() {
    return Container(
      width: 240,
      height: 30,
      padding: EdgeInsets.zero,
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.blue),
            hintText: "Name",
            fillColor: Colors.blue),
        padding: EdgeInsets.zero,
        value: _dropdownIndex,
        dropdownColor: Colors.lightBlueAccent,
        onChanged: (value) {
          setState(() {
            _dropdownIndex = value as int;
            _currentImageIndex = _dropdownIndex;
          });
        },
        items: preDefinedFrames.map((map) {
          return DropdownMenuItem(
            value: map['RotateIndex'],
            child: Text(
              map['Name'],
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget configuratorViewSwitcher() {
    return ElevatedButton(
        onPressed: () {
          if (_configuratorView == ConfiguratorView.exterior) {
            setState(() => _configuratorView = ConfiguratorView.interior);
          } else if (_configuratorView == ConfiguratorView.interior) {
            setState(() => _configuratorView = ConfiguratorView.exterior);
          }
        },
        child: Text(_configuratorView == ConfiguratorView.exterior
            ? 'Switch to interior view'
            : 'Switch to exterior view'));
  }

  List<Widget> changeConfigsButtons(ConfigStore store) {
    List<Widget> buttons = [];
    imagesMapping.forEach((index, value) {
      buttons.add(const SizedBox(width: double.maxFinite, height: 10));
      buttons.add(Text("$index :"));
      buttons.add(Container(width: double.maxFinite));
      if (value.runtimeType != String) {
        value['values'].forEach((index_, value_) {
          buttons.add(ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      store.configurations[index] == value_['value']
                          ? Colors.blueAccent
                          : Colors.lightBlueAccent)),
              onPressed: () => store.onPressConfig(index, value_),
              child: Text("$index_ - price: ${value_['cost']}")));
        });
      }
    });
    return buttons;
  }

  sideMenuWidgets(ConfigStore store) {
    List<SideMenuItem> sideMenuItems = [];
    imagesMapping.forEach((key, value) {
      if (value['display_as'] != null) {
        if (value['display_as'] == 'block_selection') {
          Map<String, Map<String, dynamic>> selectionItems = {};
          List<SelectionBlock> selectionBlocks = [];
          selectionItems.addAll(value['values']);
          selectionItems.forEach((key_, value_) {
            selectionBlocks.add(SelectionBlock(
              isSelected: store.configurations[key] == value_['value'],
              onTap: () => store.onPressConfig(key, value_),
              readMoreTitle: "Read More",
              currentSelectionBlock: SelectionBlockModel(
                title: value_['name'],
                description: value_['description'] ?? "",
                details: 'a',
                price: value_['cost'].toString(),
              ),
            ));
          });
          sideMenuItems.add(SideMenuItem(
            subsectionItems: selectionBlocks
                .map((e) => SubsectionItem(title: null, widget: e))
                .toList(),
            subtitle: '',
            title: key,
          ));
        } else if (value['display_as'] == 'thumbnail_selection') {
          Map<String, Map<String, dynamic>> thumbnailItems = {};
          thumbnailItems.addAll(value['values']);
          List<ThumbnailItemModel> thumbnailItemModels = [];
          thumbnailItems.forEach((key, value) {
            thumbnailItemModels.add(ThumbnailItemModel(
              title: value['name'],
              image: value['image'],
              price: value['cost'],
            ));
          });
          sideMenuItems.add(SideMenuItem(
            subsectionItems: [
              SubsectionItem(
                  title: null,
                  widget: ThumbnailSection(
                      title: "thumnbail name",
                      thumbnailItems: thumbnailItemModels))
            ],
            subtitle: '',
            title: key,
          ));
        } else {
          print("This is not display as block or thumbnail");
        }
      } else {
        print("This is not display as block or thumbnail");
      }
    });
    return SideMenuSection(
      sideMenuItems: sideMenuItems,
      onClick: (String s) {},
    );
  }
}
