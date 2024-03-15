import 'dart:convert';
import 'dart:io';

import 'package:rfw/formats.dart';
import 'package:rfw_builder/rfw_builder.dart';

void main() {
  File rfwFile = File('data/test1.rfw');
  DynamicMap jsonData = rfw2json(rfwFile.readAsBytesSync());
  JsonEncoder encoder = JsonEncoder.withIndent('  ');

  print(encoder.convert(jsonData));
}
