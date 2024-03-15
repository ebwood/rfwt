import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:rfw_builder/rfw_txt.dart';

void main() {
  File inputRfwfile = File('data/test2.rfw');
  Uint8List inputRfwBytes = inputRfwfile.readAsBytesSync();
  String txt = rfw2txt(inputRfwBytes);
  print(txt);
  File txtFile = File('data/output.rfwtxt');
  txtFile.writeAsStringSync(txt);
  Uint8List outputRfwBytes = txt2rfw(txt);
  print(ListEquality().equals(inputRfwBytes, outputRfwBytes));
}
