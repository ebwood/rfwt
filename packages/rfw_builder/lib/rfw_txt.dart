import 'dart:typed_data';

import 'package:rfw/formats.dart';

import 'package:rfw_builder/rfw_builder.dart';

// Parse .rfw to .rfwtxt
String rfw2txt(Uint8List bytes) => rwl2txt(decodeLibraryBlob(bytes));

// Parse RemoteWidgetLibrary to .rfwtxt
String rwl2txt(RemoteWidgetLibrary library) =>
    library.accept(TxtVisitor()).toString();

// Parse .rfwtxt format to .rfw format
Uint8List txt2rfw(String txt) => encodeLibraryBlob(txt2rfl(txt));

// Parse .rfwtxt to RemoteWidgetLibrary
RemoteWidgetLibrary txt2rfl(String txt) => parseLibraryFile(txt);
