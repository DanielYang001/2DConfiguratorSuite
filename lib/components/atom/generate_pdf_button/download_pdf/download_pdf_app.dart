import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadPdf(Uint8List pdfBytes) async {
  var file = File('');

  var status = await Permission.storage.status;
  
  if (status != PermissionStatus.granted) {
      status = await Permission.storage.request();
  }

  if (status.isGranted) {
      const downloadsFolderPath = '/storage/emulated/0/Download/';
      Directory dir = Directory(downloadsFolderPath);
      file = File('${dir.path}/download.pdf');
  }

  await file.writeAsBytes(pdfBytes.buffer.asUint8List(pdfBytes.offsetInBytes, pdfBytes.lengthInBytes));
}