import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rt_10055_2D_configurator_suite/components/logo_view.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/hotspots/hotspots.dart';
import 'package:rt_10055_2D_configurator_suite/stores/HotspotsStore.dart';

import 'package:widgets_to_image/widgets_to_image.dart';

// Enum for rotation direction
enum RotationDirection { clockwise, anticlockwise }

// WidgetsToImageController to access widget
// WidgetsToImageController imageConvertcontroller = WidgetsToImageController();

class ImageView360 extends StatefulWidget {
  final double width;

  // final double height;

  final Map<String, String> imagesMapping;

  final int? frames;

  // By default false. If set to true, the images will be displayed in incremented manner.
  final bool autoRotate;

  // By default true. If set to false, the gestures to rotate the image will be disabed.
  final bool allowSwipeToRotate;

  // By default 1. The no of cycles the whole image rotation should take place.
  final int rotationCount;

  // By default 1. Based on the value the sensitivity of swipe gesture increases and decreases proportionally
  final int swipeSensitivity;

  // By default Duration(milliseconds: 80). The time interval between shifting from one image frame to other.
  final Duration frameChangeDuration;

  // By default RotationDirection.clockwise. Based on the value the direction of rotation is set.
  final RotationDirection rotationDirection;

  // Callback function to provide you the index of current image when image frame is changed.
  final Function(int? currentImageIndex)? onImageIndexChanged;

  final Object? logoData;

  final int? defaultImageIndex;

  final WidgetsToImageController? imageConvertController;

  final bool? fromLocalDevice;

  final String? assetsPath;

  final HotspotsStore? hsStore;

  final bool hotspotsEditMode;

  final HotspotsController? hotspotsController;

  const ImageView360({
    required Key key,
    required this.width,
    // required this.height,
    required this.hotspotsEditMode,
    required this.hotspotsController,
    required this.hsStore,
    required this.imagesMapping,
    required this.imageConvertController,
    this.defaultImageIndex,
    this.frames,
    this.autoRotate = false,
    this.allowSwipeToRotate = true,
    this.rotationCount = 1,
    this.swipeSensitivity = 1,
    this.rotationDirection = RotationDirection.clockwise,
    this.frameChangeDuration = Duration.zero,
    this.onImageIndexChanged,
    this.logoData,
    this.fromLocalDevice,
    this.assetsPath,
  }) : super(key: key);

  @override
  _ImageView360State createState() => _ImageView360State();
}

class _ImageView360State extends State<ImageView360> {
  late int rotationIndex, senstivity;
  int rotationCompleted = 0;
  double localPosition = 0.0;
  late Function(int? currentImageIndex) onImageIndexChanged;

  double? willcalculateheight;

  double cornerWidth = 12;
  Size _logoSize = const Size(100, 100);
  Rect _logoRegion = const Rect.fromLTRB(0, 0, 0, 0);
  Offset _logoPosition = const Offset(0, 0);
  Offset _oppoPosition = const Offset(0, 0);
  bool _isLogoHover = false;
  bool _isLogoSelected = false;
  bool _isLogoMove = false;
  bool _isLogoResize = false;
  bool _isLogoResizeDirection = false;
  Object? _logoData;
  List<List<Image>>? _preCachedImgs = [];
  double? _skew = 0;

  bool isAndroid = !kIsWeb && Platform.isAndroid;

  @override
  void initState() {
    defineImagesToCache();
    senstivity = widget.swipeSensitivity;
    // To bound the sensitivity range from 1-5
    if (senstivity < 1) {
      senstivity = 1;
    } else if (senstivity > 5) {
      senstivity = 5;
    }
    onImageIndexChanged = widget.onImageIndexChanged ?? (currentImageIndex) {};
    rotationIndex = widget.defaultImageIndex ??
        (widget.rotationDirection == RotationDirection.anticlockwise
            ? 0
            : (widget.frames! - 1));

    if (widget.autoRotate) {
      // To start the image rotation
      rotateImage();
    }

    _logoData = widget.logoData;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (kIsWeb) preCacheImages();
    super.didChangeDependencies();
    _logoPosition = Offset(
        (widget.width - _logoSize.width) / 2, (willcalculateheight ?? 0) / 2);
    updateLogoRegion();
  }

  void defineImagesToCache() {
    List<List<Image>> preCachedImgs_ = [];
    for (int i = 0; i <= widget.frames!; i++) {
      String _frame = i > 9 ? i.toString() : '0$i';
      List<Image> imgs_ = [];
      widget.imagesMapping.forEach((key, value) {
        String imageDomain = true
            ? "assets/"
            : "https://2d-configurator-test.s3.eu-west-2.amazonaws.com/";
        String imagePath =
            '${imageDomain}output_jpegs/${value.toString().replaceAll('00.png', '$_frame.png')}';
        if (value.contains('.png')) {
          imgs_.add(Image(
            image: true
                ? widget.fromLocalDevice!
                    ? Image.file(File('${widget.assetsPath}/$imagePath')).image
                    : Image.asset(imagePath).image
                : NetworkImage(imagePath),
            gaplessPlayback: true,
            width: widget.width,
          ));
        }
      });
      preCachedImgs_!.add(imgs_);
    }

    setState(() => _preCachedImgs = preCachedImgs_);
  }

  void preCacheImages() {
    _preCachedImgs!.forEach((element) {
      element.forEach((element2) {
        precacheImage(element2.image, context);
      });
    });
  }

  void updateLogoRegion() {
    if (willcalculateheight == null) return;
    final regionWidth = widget.width / 3;
    final regionHeight = willcalculateheight! / 3;
    _logoRegion = Rect.fromLTWH(
      widget.width / 2 - regionWidth / 2,
      willcalculateheight! / 2 - regionHeight / 2,
      regionWidth - _logoSize.width,
      regionHeight - _logoSize.height,
    );
  }

  viewerHeight() {
    if (_preCachedImgs?.first.first.height == null) {
      viewerHeight();
    } else {
      setState(() {
        willcalculateheight = _preCachedImgs?.first.first.height;
      });
    }
  }

  List<Image> oneImageStack(int frame) {
    return _preCachedImgs![frame];
  }

  List<Stack> imagesStacks() {
    List<Stack> imagesStacks_ = [];
    for (int i = 0; i <= widget.frames!; i++) {
      imagesStacks_.add(Stack(children: oneImageStack(i)));
    }
    return imagesStacks_;
  }

  @override
  Widget build(BuildContext context) {
    List<Stack> imagesStacks_ = imagesStacks();
    return GestureDetector(
        onHorizontalDragEnd: (details) {
          if (!_isLogoSelected) {
            localPosition = 0.0;
          } else {
            dragEndForLogo(details);
          }
        },
        onHorizontalDragUpdate: (details) {
          if (!_isLogoSelected) {
            // Swipe check,if allowed than only will image move
            if (widget.allowSwipeToRotate) {
              _isLogoResize = false;
              _isLogoMove = false;
              if (details.delta.dx > 0) {
                handleRightSwipe(details);
              } else if (details.delta.dx < 0) {
                handleLeftSwipe(details);
              }
            }
          } else {
            dragMoveForLogo(details);
          }
        },
        onHorizontalDragStart: (details) {
          _isLogoSelected = isLogoArea(details.localPosition);

          if (_isLogoSelected) {
            dragStartForLogo(details);
          }
        },
        child: Listener(
            onPointerHover: (event) => mouseHoverEvent(event),
            child: Stack(children: [
              if (kIsWeb) Stack(children: imagesStacks_),
              Container(
                width: widget.width,
                color: Colors.white,
                child: const Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator())),
              ),
              WidgetsToImage(
                controller: widget.imageConvertController!,
                child: Stack(children: [
                  imagesStacks_[rotationIndex],
                  _logoData != null
                      ? MouseRegion(
                          cursor: getCursor(),
                          child: SizedBox(
                              width: widget.width,
                              // height: willcalculateheight,
                              child: LogoView(
                                  visible: (rotationIndex > 56 &&
                                          rotationIndex < 70) ||
                                      (rotationIndex > 0 && rotationIndex < 16),
                                  skew: _skew ?? 0,
                                  logoPosition: _logoPosition,
                                  logoSize: _logoSize,
                                  cornerWidth: cornerWidth,
                                  logoData: _logoData!.toString(),
                                  select: _isLogoSelected)))
                      : Container()
                ]),
              ),
              Hotspots(
                editMode: widget.hotspotsEditMode,
                hsStore: widget.hsStore!,
                currentImageIndex: rotationIndex,
                hotspotsController: widget.hotspotsController,
              ),
            ]))
        // Image(
        //   image: widget.imageList[rotationIndex],
        //   gaplessPlayback: true,
        // ),
        );
  }

  SystemMouseCursor getCursor() {
    return _isLogoHover
        ? _isLogoSelected
            ? _isLogoMove
                ? SystemMouseCursors.grab
                : _isLogoResizeDirection
                    ? SystemMouseCursors.resizeUpLeftDownRight
                    : SystemMouseCursors.resizeUpRightDownLeft
            : SystemMouseCursors.grab
        : SystemMouseCursors.basic;
  }

  void mouseHoverEvent(PointerHoverEvent event) {
    bool newLogoHover = isLogoArea(event.localPosition);
    bool newLogoResize = isLogoResize(event.localPosition);

    if (_isLogoSelected) {
      if (newLogoHover != _isLogoHover) {
        setState(() {
          if (newLogoHover) {
            _isLogoHover = true;
            if (newLogoResize) {
              _isLogoResize = true;
              _isLogoMove = false;
            } else {
              _isLogoResize = false;
              _isLogoMove = true;
            }
          } else {
            _isLogoHover = false;
          }
        });
      } else {
        if (newLogoHover) {
          if (_isLogoResize != newLogoResize) {
            setState(() {
              if (newLogoResize) {
                _isLogoResize = true;
                _isLogoMove = false;
              } else {
                _isLogoResize = false;
                _isLogoMove = true;
              }
            });
          }
        }
      }
    } else {
      if (newLogoHover != _isLogoHover) {
        setState(() {
          _isLogoHover = newLogoHover;
        });
      }
    }
  }

  void dragStartForLogo(DragStartDetails details) {
    setState(() {
      if (isLogoResize(details.localPosition)) {
        _oppoPosition = getLogoOppoPosition(details.localPosition);
        _isLogoResize = true;
        _isLogoMove = false;
      } else if (isLogoRemove(details.localPosition)) {
        _logoData = null;
      } else {
        _isLogoResize = false;
        _isLogoMove = true;
      }
    });
  }

  void dragMoveForLogo(DragUpdateDetails details) {
    setState(() {
      if (_isLogoResize) {
        setLogoRectForResize(details.localPosition);
      } else {
        var newX = details.localPosition.dx - _logoSize.width / 2;
        if (newX < 0) newX = 0;

        var newY = details.localPosition.dy - _logoSize.height / 2;
        if (newY < 0) newY = 0;

        if (newX < _logoRegion.left) newX = _logoRegion.left;
        if (newX > _logoRegion.right) newX = _logoRegion.right;
        if (newY < _logoRegion.top) newY = _logoRegion.top;
        if (newY > _logoRegion.bottom) newY = _logoRegion.bottom;

        _logoPosition = Offset(newX, newY);
      }
    });
  }

  void dragEndForLogo(DragEndDetails details) {
    if (_isLogoResize) {
      setState(() {
        _isLogoMove = true;
        _isLogoResize = false;
      });
    } else {
      _isLogoMove = false;
      _isLogoResize = false;
    }
  }

  bool isLogoArea(Offset offset) {
    if (offset.dx > _logoPosition.dx &&
        offset.dx < _logoPosition.dx + _logoSize.width) {
      if (offset.dy > _logoPosition.dy &&
          offset.dy < _logoPosition.dy + _logoSize.height) {
        return true;
      }
    }
    return false;
  }

  bool isLogoRemove(Offset details) {
    if (details.dx > _logoPosition.dx + _logoSize.width - 32 &&
        details.dx < _logoPosition.dx + _logoSize.width - cornerWidth) {
      if (details.dy > _logoPosition.dy + 12 &&
          details.dy < _logoPosition.dy + 32) {
        return true;
      }
    }
    return false;
  }

  bool isLogoResize(Offset details) {
    if (details.dx > _logoPosition.dx &&
        details.dx < _logoPosition.dx + cornerWidth) {
      if (details.dy > _logoPosition.dy &&
          details.dy < _logoPosition.dy + cornerWidth) {
        _isLogoResizeDirection = true;
        return true;
      }

      if (details.dy > _logoPosition.dy + _logoSize.height - cornerWidth &&
          details.dy < _logoPosition.dy + _logoSize.height) {
        _isLogoResizeDirection = false;
        return true;
      }
    } else if (details.dx > _logoPosition.dx + _logoSize.width - cornerWidth &&
        details.dx < _logoPosition.dx + _logoSize.width) {
      if (details.dy > _logoPosition.dy &&
          details.dy < _logoPosition.dy + cornerWidth) {
        _isLogoResizeDirection = false;
        return true;
      }

      if (details.dy > _logoPosition.dy + _logoSize.height - cornerWidth &&
          details.dy < _logoPosition.dy + _logoSize.height) {
        _isLogoResizeDirection = true;
        return true;
      }
    }

    return false;
  }

  Offset getLogoOppoPosition(Offset details) {
    if (details.dx > _logoPosition.dx &&
        details.dx < _logoPosition.dx + cornerWidth) {
      if (details.dy > _logoPosition.dy &&
          details.dy < _logoPosition.dy + cornerWidth) {
        return Offset(_logoPosition.dx + _logoSize.width,
            _logoPosition.dy + _logoSize.height);
      }

      if (details.dy > _logoPosition.dy + _logoSize.height - cornerWidth &&
          details.dy < _logoPosition.dy + _logoSize.height) {
        return Offset(_logoPosition.dx + _logoSize.width, _logoPosition.dy);
      }
    } else if (details.dx > _logoPosition.dx + _logoSize.width - cornerWidth &&
        details.dx < _logoPosition.dx + _logoSize.width) {
      if (details.dy > _logoPosition.dy &&
          details.dy < _logoPosition.dy + cornerWidth) {
        return Offset(_logoPosition.dx, _logoPosition.dy + _logoSize.height);
      }

      if (details.dy > _logoPosition.dy + _logoSize.height - cornerWidth &&
          details.dy < _logoPosition.dy + _logoSize.height) {
        return _logoPosition;
      }
    }
    return _logoPosition;
  }

  void setLogoRectForResize(Offset details) {
    var left = min(details.dx, _oppoPosition.dx);
    var right = max(details.dx, _oppoPosition.dx);
    var top = min(details.dy, _oppoPosition.dy);
    var bottom = max(details.dy, _oppoPosition.dy);

    left = max(left, _logoRegion.left);
    right = min(right, _logoRegion.right + _logoSize.width);
    top = max(top, _logoRegion.top);
    bottom = min(bottom, _logoRegion.bottom + _logoSize.height);

    _logoPosition = Offset(left, top);
    _logoSize = Size(right - left, bottom - top);

    updateLogoRegion();
  }

  void rotateImage() async {
    // Check for rotationCount
    if (rotationCompleted < widget.rotationCount) {
      // Frame change duration logic
      await Future.delayed(widget.frameChangeDuration);
      if (mounted) {
        setState(() {
          if (widget.rotationDirection == RotationDirection.anticlockwise) {
            // Logic to bring the frame to initial position on cycle complete in positive direction
            if (rotationIndex < widget.frames! - 1) {
              rotationIndex++;
            } else {
              rotationCompleted++;
              rotationIndex = 0;
            }
          } else {
            // Logic to bring the frame to initial position on cycle complete in negative direction
            if (rotationIndex > 0) {
              rotationIndex--;
            } else {
              rotationCompleted++;
              rotationIndex = widget.frames! - 1;
            }
          }
        });

        onImageIndexChanged(rotationIndex);
      }
      //Recursive call
      rotateImage();
    }
  }

  void handleRightSwipe(DragUpdateDetails details) {
    int? originalindex = rotationIndex;
    if ((localPosition + (pow(4, (6 - senstivity)) / (widget.frames!))) <=
        details.localPosition.dx) {
      _skew = _skew! - 0.03;
      rotationIndex = rotationIndex + 1;
      localPosition = details.localPosition.dx;
    }
    // Check to ignore rebuild of widget is index is same
    if (originalindex != rotationIndex) {
      setState(() {
        if (rotationIndex < widget.frames! - 1) {
          rotationIndex = rotationIndex;
        } else {
          rotationIndex = 0;
        }
      });
      onImageIndexChanged(rotationIndex);
    }
  }

  void handleLeftSwipe(DragUpdateDetails details) {
    double distancedifference = (details.localPosition.dx - localPosition);
    int? originalindex = rotationIndex;
    if (distancedifference < 0) {
      distancedifference = (-distancedifference);
    }
    if (distancedifference >= (pow(4, (6 - senstivity)) / (widget.frames!))) {
      _skew = _skew! + 0.03;
      rotationIndex = rotationIndex - 1;
      localPosition = details.localPosition.dx;
    }
    // Check to ignore rebuild of widget is index is same
    if (originalindex != rotationIndex) {
      setState(() {
        if (rotationIndex > 0) {
          rotationIndex = rotationIndex;
        } else {
          rotationIndex = widget.frames! - 1;
        }
      });
      onImageIndexChanged(rotationIndex);
    }
  }
}
