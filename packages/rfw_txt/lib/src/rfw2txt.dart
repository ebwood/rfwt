import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:rfw/formats.dart';

import 'rwl2json.dart';
import 'rwl2txt.dart';

// Parse .rfw to .rfwtxt
String rfw2txt(Uint8List bytes) {
  RemoteWidgetLibrary rwl = decodeLibraryBlob(bytes);
  String output = rwl2txt(rwl);
  if (ListEquality()
          .equals(bytes, encodeLibraryBlob(parseLibraryFile(output))) ==
      false) {
    throw Exception('rfw2txt failed');
  }
  return output;
}

// Parse .rfw to json
Map<String, dynamic> rfw2json(Uint8List bytes) {
  RemoteWidgetLibrary rwl = decodeLibraryBlob(bytes);
  return rwl2json(rwl);
}
