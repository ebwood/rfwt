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

// Parse json to rfw data txt
String json2dataTxt(Map<String, dynamic> map) => value2DataTxt(map).toString();

// Parse rfw data txt to json
DynamicMap dataTxt2json(String txt) => parseDataFile(txt);

// Parse json to rfw data
Uint8List json2data(DynamicMap map) => encodeDataBlob(map);

// Parse rfw data to json
DynamicMap data2json(Uint8List data) => decodeDataBlob(data) as DynamicMap;

// Parse rfw data to rfw data txt
String data2dataTxt(Uint8List data) => json2dataTxt(data2json(data));

// Parse rfw data txt to rfw data
Uint8List dataTxt2data(String txt) => encodeDataBlob(parseDataFile(txt));
