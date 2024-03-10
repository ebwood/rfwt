library txt2rfw;

import 'dart:typed_data';

import 'package:rfw/formats.dart';

// Parse .rfwtxt format to .rfw format
Uint8List txt2rfw(String txt) {
  return encodeLibraryBlob(txt2rfl(txt));
}

// Parse .rfwtxt to rfl
RemoteWidgetLibrary txt2rfl(String txt) {
  return parseLibraryFile(txt);
}
