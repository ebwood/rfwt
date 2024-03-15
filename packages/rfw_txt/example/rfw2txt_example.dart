import 'dart:io';

import 'package:rfw_txt/src/rfw2txt.dart';

void main() {
  File rfwFile = File('../data/test1.rfw');
  String txt = rfw2txt(rfwFile.readAsBytesSync());
  print(txt);
  Map<String, dynamic> jsonData = rfw2json(rfwFile.readAsBytesSync());
  print(jsonData);
}
