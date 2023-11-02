import 'dart:async';

import 'package:file_picker/file_picker.dart';

Future<Object> openFileExplorer() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    PlatformFile platformFile = result.files.first;
    return platformFile.path!;
  }
  return '';
}