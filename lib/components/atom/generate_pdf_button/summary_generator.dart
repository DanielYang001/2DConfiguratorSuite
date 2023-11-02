import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/generate_pdf_button/download_pdf/download_pdf.dart';

Future<void> summaryGenerator(
    Uint8List carImagebytes,
    double totalCost,
    Map<dynamic, dynamic> configMapping,
    Map<String, int> printConfigurations) async {
  final pdf = pw.Document();

  final font = await PdfGoogleFonts.nunitoExtraLight();
  final carImage = pw.MemoryImage(carImagebytes);

  pdf.addPage(
    pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
              child: pw.Column(children: [
            pw.Text('Car Info', style: pw.TextStyle(font: font, fontSize: 32)),
            pw.SizedBox(height: 20),
            pw.Text('Total Cost: $totalCost',
                style: pw.TextStyle(font: font, fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Image(carImage),
            pw.SizedBox(height: 20),
            pw.Text(configStrings(configMapping, printConfigurations),
                style: pw.TextStyle(font: font, fontSize: 16))
          ]));
        }),
  ); // Page

  final Uint8List pdfBytes = await pdf.save();
  await downloadPdf(pdfBytes);
}

String configStrings(
    Map<dynamic, dynamic> configMapping, Map<String, int> printConfigurations) {
  String configs = '';

  printConfigurations.forEach((key, value) {
    final values = configMapping[key]['values'] as Map<String, dynamic>;
    values.forEach((key2, value2) {
      final map = value2 as Map<String, dynamic>;
      if (map['value'] == value && map.containsKey('cost')) {
        configs += '$key: $key2 - ${map['cost']}\n';
      }
    });
  });

  return configs;
}
