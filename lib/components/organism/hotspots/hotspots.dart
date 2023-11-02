import 'package:flutter/material.dart';
import 'package:rt_10055_2D_configurator_suite/stores/HotspotsStore.dart';

class Hotspots extends StatefulWidget {
  HotspotsStore hsStore;
  int currentImageIndex;
  HotspotsController? hotspotsController;
  bool editMode;

  Hotspots(
      {super.key,
      required this.hsStore,
      required this.currentImageIndex,
      this.editMode = false,
      this.hotspotsController});

  @override
  State<StatefulWidget> createState() {
    return _hotspotsState();
  }
}

class _hotspotsState extends State<Hotspots> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> hotspots = widget.hsStore.hotspots();

    return GestureDetector(
        onTap: () => widget.hotspotsController!.showHideOptions(false),
        child: Stack(
          children: hotspots.entries
              .map((e) => hotspotPoint(widget.hsStore, e.key, context))
              .toList(),
        ));
  }

  Widget hotspotPoint(
      HotspotsStore hsStore, String hotspotId, BuildContext context) {
    Map<dynamic, dynamic> hotspotInfo = hsStore.hotspots()[hotspotId];
    double dx = hotspotInfo['offsetsOnFrames']
        [widget.currentImageIndex!]!['offset']['x'];
    double dy = hotspotInfo['offsetsOnFrames']
        [widget.currentImageIndex!]!['offset']['y'];
    bool visibility =
        hotspotInfo['offsetsOnFrames'][widget.currentImageIndex!]!['visible'];

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        positioned(
            dx: dx,
            dy: dy,
            child: (widget.hotspotsController!.showHotspotOptions &&
                    hotspotInfo['active'])
                ? Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      // color: Colors.white,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    right: 5, left: 5, top: 3, bottom: 3),
                                child: InkWell(
                                  onTap: () {
                                    hsStore.toggleVisibility(
                                        hotspotId, widget.currentImageIndex!);
                                    widget.hotspotsController!
                                        .showHideOptions(false);
                                    // setState(() => hotspotsController!.showHotspotOptions = false);
                                  },
                                  child: Text(
                                      visibility
                                          ? 'Make invisible'
                                          : 'Make visible',
                                      style: const TextStyle(fontSize: 12)),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Container(
                                  width: 150,
                                  height: 1,
                                  color: Colors.grey[100],
                                )),
                            Container(
                                padding: const EdgeInsets.only(
                                    right: 5, left: 5, top: 3, bottom: 3),
                                child: InkWell(
                                  onTap: () {
                                    editHotspotDialog(
                                        hsStore, hotspotId, context);
                                    widget.hotspotsController!
                                        .showHideOptions(false);
                                  },
                                  child: const Text('Edit name',
                                      style: TextStyle(fontSize: 12)),
                                ))
                          ]),
                    ))
                : const SizedBox()),
        // positioned(
        //     child: Padding(
        //         padding: const EdgeInsetsDirectional.only(bottom: 00),
        //         child: Text(
        //           hotspotInfo['name'],
        //           style: const TextStyle(
        //               fontSize: 13, height: 1.1, color: Colors.white),
        //         )),
        //     dx: dx + 23,
        //     dy: dy),
        positioned(
          dx: dx,
          dy: dy,
          child: draggable(hotspotId),
        )
      ],
    );
  }

  Widget draggable(String hotspotId) {
    Map<dynamic, dynamic> hotspotInfo = widget.hsStore.hotspots()[hotspotId];

    Widget circle = Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: hotspotInfo['offsetsOnFrames']
                        [widget.currentImageIndex!]!['visible']
                    ? Colors.white
                    : Colors.transparent,
                spreadRadius: 1,
                blurRadius: 15)
          ],
          color: hotspotInfo['offsetsOnFrames']
                  [widget.currentImageIndex!]!['visible']
              ? Colors.white
              : widget.editMode
                  ? Colors.white.withOpacity(0.5)
                  : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(500))),
    );

    return widget.editMode
        ? Draggable(
            feedback: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(500))),
            ),
            onDraggableCanceled: (velocity, offset) {
              widget.hsStore.updateHotspotPosition(
                  hotspotId, widget.currentImageIndex!, offset);
            },
            onDragStarted: () {
              widget.hsStore.setActive(hotspotId);
            },
            child: InkWell(
                onFocusChange: (bool focus) {
                  if (focus) {
                    widget.hotspotsController!.showHideOptions(false);
                  }
                },
                onTap: () {
                  widget.hsStore.setActive(hotspotId);
                  widget.hotspotsController!.showHideOptions(false);
                },
                onLongPress: () {
                  widget.hotspotsController!.showHideOptions(false);
                  widget.hsStore.setActive(hotspotId);
                  widget.hotspotsController!.showHideOptions(true);
                  Future.delayed(const Duration(milliseconds: 100),
                      () => widget.hotspotsController!.showHideOptions(true));
                },
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  // Text(hotspotInfo['name']),
                  circle
                ])),
          )
        : circle;
  }

  Widget positioned(
      {required Widget child, required double dx, required double dy}) {
    return Center(
      child: SizedBox(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
                left: dx,
                top: dy,
                child: Align(alignment: Alignment.center, child: child))
          ],
        ),
      ),
    );
  }

  void editHotspotDialog(
      HotspotsStore hsStore, String hotspotId, BuildContext context) {
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
                                widget.hotspotsController!.editHotspotName(val),
                            decoration: const InputDecoration(
                                hintText: 'Hotspot name',
                                hintStyle: TextStyle(fontSize: 15)))),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: 250,
                        child: FilledButton(
                            onPressed: () {
                              hsStore.editHotspot(hotspotId,
                                  widget.hotspotsController!.hotspotName);
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
}

class HotspotsController extends ChangeNotifier {
  bool showHotspotOptions = false;
  String hotspotName = '';

  void showHideOptions(bool visible) {
    showHotspotOptions = visible;
    notifyListeners();
  }

  void editHotspotName(String value) {
    hotspotName = value;
    notifyListeners();
  }
}
