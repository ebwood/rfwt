import 'dart:typed_data';

import 'package:rfw/formats.dart';

// Parse .rfwtxt format to .rfw format
Uint8List txt2rfw(String txt) {
  return encodeLibraryBlob(txt2rfl(txt));
}

// Parse .rfwtxt to RemoteWidgetLibrary
RemoteWidgetLibrary txt2rfl(String txt) {
  return parseLibraryFile(txt);
}
