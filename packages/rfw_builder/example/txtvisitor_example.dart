import 'dart:io';

import 'package:rfw_builder/rfw_builder.dart';
import 'package:rfw_builder/rfw_txt.dart';

void main() {
  File input = File('data/test2.rfwtxt');
  final rwl = txt2rwl(input.readAsStringSync());
  final result = rwl.accept(TxtVisitor());
  print(result);
  File file = File('test.rfwtxt');
  file.writeAsStringSync(result);
}
