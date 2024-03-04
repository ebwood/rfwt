@TestOn('vm')
import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:collection/collection.dart';

void main() {
  test('txt2rfw without output path', () async {
    Process process = await Process.start(
        'dart', ['run', 'bin/txt2rfw.dart', "test/test.rfwtxt"]);
    await process.stdout.transform(utf8.decoder).forEach(print);
    await process.stderr.transform(utf8.decoder).forEach(print);
    File resultFile = File('test/match.rfw');
    File outputFile = File('test.rfw');
    expect(outputFile.existsSync(), true);
    expect(
        ListEquality()
            .equals(resultFile.readAsBytesSync(), resultFile.readAsBytesSync()),
        true);

    outputFile.delete();
  });

  test('txt2rfw with output path', () async {
    Process process = await Process.start('dart',
        ['run', 'bin/txt2rfw.dart', "test/test.rfwtxt", "-o", "test.rfw"]);
    await process.stdout.transform(utf8.decoder).forEach(print);
    await process.stderr.transform(utf8.decoder).forEach(print);
    File resultFile = File('test/match.rfw');
    File outputFile = File('test.rfw');
    expect(outputFile.existsSync(), true);
    expect(
        ListEquality()
            .equals(resultFile.readAsBytesSync(), resultFile.readAsBytesSync()),
        true);

    outputFile.delete();
  });
}
