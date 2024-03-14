@TestOn('vm')

import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:test/test.dart';

void main() {
  test('txt2rfw without output path', () async {
    Process process = await Process.start(
        'dart', ['run', 'bin/txt2rfw.dart', "data/test1.rfwtxt"]);
    await process.stdout.transform(utf8.decoder).forEach(print);
    await process.stderr.transform(utf8.decoder).forEach(print);
    File matchFile = File('data/test1.rfw');
    File outputFile = File('test1.rfw');
    expect(outputFile.existsSync(), true);
    expect(
        ListEquality()
            .equals(matchFile.readAsBytesSync(), matchFile.readAsBytesSync()),
        true);

    outputFile.delete();
  });

  test('txt2rfw with output path', () async {
    Process process = await Process.start('dart',
        ['run', 'bin/txt2rfw.dart', "data/test2.rfwtxt", "-o", "test/output2.rfw"]);
    await process.stdout.transform(utf8.decoder).forEach(print);
    await process.stderr.transform(utf8.decoder).forEach(print);
    File matchFile = File('data/test2.rfw');
    File outputFile = File('test/output2.rfw');
    expect(outputFile.existsSync(), true);
    expect(
        ListEquality()
            .equals(matchFile.readAsBytesSync(), matchFile.readAsBytesSync()),
        true);

    outputFile.delete();
  });
}
