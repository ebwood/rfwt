@TestOn('vm')

import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:test/test.dart';

void main() {
  test('txt2rfw without output path', () async {
    Process process = await Process.start(
        'dart', ['run', 'bin/txt2rfw.dart', "test/test.rfwtxt"]);
    await process.stdout.transform(utf8.decoder).forEach(print);
    await process.stderr.transform(utf8.decoder).forEach(print);
    File matchFile = File('test/match.rfw');
    File outputFile = File('test.rfw');
    expect(outputFile.existsSync(), true);
    expect(
        ListEquality()
            .equals(matchFile.readAsBytesSync(), matchFile.readAsBytesSync()),
        true);

    outputFile.delete();
  });

  test('txt2rfw with output path', () async {
    Process process = await Process.start('dart',
        ['run', 'bin/txt2rfw.dart', "test/test.rfwtxt", "-o", "test.rfw"]);
    await process.stdout.transform(utf8.decoder).forEach(print);
    await process.stderr.transform(utf8.decoder).forEach(print);
    File matchFile = File('test/match.rfw');
    File outputFile = File('test.rfw');
    expect(outputFile.existsSync(), true);
    expect(
        ListEquality()
            .equals(matchFile.readAsBytesSync(), matchFile.readAsBytesSync()),
        true);

    outputFile.delete();
  });
}
