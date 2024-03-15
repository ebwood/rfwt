import 'dart:io';
import 'dart:typed_data';

import 'package:rfw_txt/src/txt2rfw.dart';


void main() {
  File file = File('../data/test1.rfwtxt');
  Uint8List bytes = txt2rfw(file.readAsStringSync());
  print(bytes);
}