import 'dart:io';

import 'package:rfw2txt/rfw2txt.dart';

void main() {
  File rfwFile = File('test.rfw');
  String txt = rfw2txt(rfwFile.readAsBytesSync());
  print(txt);
}
