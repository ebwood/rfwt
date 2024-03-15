import 'dart:io';
import 'dart:typed_data';

import 'package:rfw_builder/rfw_txt.dart';

void main() {
  File file = File('data/test2.rfwtxt');
  Uint8List bytes = txt2rfw(file.readAsStringSync());
}
