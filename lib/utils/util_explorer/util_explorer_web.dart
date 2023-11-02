import 'dart:async';
import 'dart:html' as html;

Future<Object> openFileExplorer() async {
  Completer completer = Completer();

  final html.FileUploadInputElement input = html.FileUploadInputElement();
  input.click();

  input.onChange.listen((event) {
    final files = input.files;
    if (files!.isNotEmpty) {
      final fileReader = html.FileReader();
      fileReader.readAsDataUrl(files[0]);
      fileReader.onLoadEnd.listen((event) {
        final logoData = fileReader.result;
        completer.complete(logoData);
      });
    }
  });

  return completer.future;
}
