import 'package:rfw/formats.dart';
import 'package:test/test.dart';

import 'package:rfw_builder/rfw_builder.dart';

void main() {
  test('TxtVisitor', () {
    TxtVisitor txtVisitor = TxtVisitor();
    // print(txtVisitor.visitLoop(Loop([1, 2, 3], )));
    expect('loop0',
        txtVisitor.visitLoopReference(LoopReference(0, [])).toString());
    expect('loop0.name',
        txtVisitor.visitLoopReference(LoopReference(0, ['name'])).toString());
  });
}
