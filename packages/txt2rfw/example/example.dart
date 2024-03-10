import 'dart:io';
import 'dart:typed_data';

import 'package:txt2rfw/txt2rfw.dart';

void main() {
  File file = File('match.rfwtxt');
  Uint8List bytes = txt2rfw(file.readAsStringSync());
  print(bytes);
}
