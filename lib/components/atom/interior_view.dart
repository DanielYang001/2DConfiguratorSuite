import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class InteriorView extends StatefulWidget {
  InteriorView({super.key, this.image, this.minScale = 1, this.maxScale = 3});
  Image? image;
  double? minScale;
  double? maxScale;

  @override
  State<InteriorView> createState() => _InteriorViewState();
}

class _InteriorViewState extends State<InteriorView> {
  double? _zoom;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: const BoxDecoration(),
          clipBehavior: Clip.hardEdge,
          child: Transform.scale(
              scale: _zoom ?? widget.minScale!,
              child: Panorama(
                child: widget.image,
              ))),
      Align(
          alignment: AlignmentDirectional.topEnd,
          child: SizedBox(
              width: 100,
              child: Column(children: [
                const Text(
                  'Scale',
                  style: TextStyle(fontSize: 14),
                ),
                Slider(
                  min: widget.minScale!,
                  max: widget.maxScale!,
                  value: _zoom ?? widget.minScale!,
                  onChanged: (double zoom_) {
                    setState(() {
                      _zoom = zoom_;
                    });
                  },
                )
              ]))),
    ]);
    // );
  }
}
