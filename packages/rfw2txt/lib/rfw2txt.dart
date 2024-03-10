import 'dart:typed_data';

import 'package:rfw/formats.dart';
import 'package:rfw2txt/rwl2json.dart';
import 'package:rfw2txt/rwl2txt.dart';

// Parse .rfw to .rfwtxt
String rfw2txt(Uint8List bytes) {
  RemoteWidgetLibrary rwl = decodeLibraryBlob(bytes);
  return rwl2txt(rwl);
}

// Parse .rfw to json
Map<String, dynamic> rfw2json(Uint8List bytes) {
  RemoteWidgetLibrary rwl = decodeLibraryBlob(bytes);
  return rwl2json(rwl);
}
