import 'package:flutter/material.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/generate_pdf_button/summary_generator.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class GeneratePDFButton extends StatefulWidget {
  const GeneratePDFButton({
    super.key,
    this.child,
    this.onPressed,
    this.loadingChild,
    this.style,
    this.loadingStyle,
    @required this.totalCost,
    @required this.printConfigurations,
    @required this.imageConvertcontroller,
    required this.configMapping,
  });
  final Widget? child;
  final Widget? loadingChild;
  final void Function()? onPressed;
  final ButtonStyle? style;
  final ButtonStyle? loadingStyle;
  final double? totalCost;
  final Map<String, int>? printConfigurations;
  final WidgetsToImageController? imageConvertcontroller;
  final Map<dynamic, dynamic> configMapping;

  @override
  State<GeneratePDFButton> createState() => _GeneratePDFButtonState();
}

class _GeneratePDFButtonState extends State<GeneratePDFButton> {
  bool _isBuildingPDF = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: _isBuildingPDF ? widget.loadingStyle : widget.style,
      child: _isBuildingPDF ? widget.loadingChild : widget.child,
    );
  }

  void onPressed() {
    if (!_isBuildingPDF) {
      printPdf();
    }
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  void printPdf() async {
    final carImagebytes = await widget.imageConvertcontroller!.capture();
    print('Finish Capture Car Image');

    setState(() {
      _isBuildingPDF = true;
    });

    if (carImagebytes != null) {
      Future.delayed(const Duration(milliseconds: 500), () async {
        await summaryGenerator(carImagebytes, widget.totalCost!,
            widget.configMapping, widget.printConfigurations!);
        print('Save PDF');

        setState(() {
          _isBuildingPDF = false;
        });
      });
    }
  }
}
