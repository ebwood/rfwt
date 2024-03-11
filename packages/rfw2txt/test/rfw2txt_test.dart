@TestOn('vm')
import 'dart:convert';
import 'dart:io';

import 'package:rfw/formats.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

void main() {
  test('rfw2txt without output path', () async {
    Process process = await Process.start(
        'dart', ['run', 'bin/rfw2txt.dart', "test/test.rfw"]);
    await process.stdout.transform(utf8.decoder).forEach(print);
    await process.stderr.transform(utf8.decoder).forEach(print);
    File matchFile = File('test/test.rfw');
    File outputTxtFile = File('test.rfwtxt');
    File outputFile = File('output.rfw');
    outputFile.writeAsBytesSync(
        encodeLibraryBlob(parseLibraryFile(outputTxtFile.readAsStringSync())));
    // use rfw encoder to convert output test.rfwtxt to test.rfw, then check the file is equal to test/test.rfw
    expect(outputFile.existsSync(), true);
    expect(
        ListEquality()
            .equals(matchFile.readAsBytesSync(), matchFile.readAsBytesSync()),
        true);

    outputFile.delete();
    outputTxtFile.delete();
  });

  test('rfw2txt with output path', () async {
    Process process = await Process.start('dart',
        ['run', 'bin/rfw2txt.dart', "test/test.rfw", "-o", "output.rfwtxt"]);
    await process.stdout.transform(utf8.decoder).forEach(print);
    await process.stderr.transform(utf8.decoder).forEach(print);
    File matchFile = File('test/test.rfw');
    File outputTxtFile = File('output.rfwtxt');
    File outputFile = File('output.rfw');
    outputFile.writeAsBytesSync(
        encodeLibraryBlob(parseLibraryFile(outputTxtFile.readAsStringSync())));
    expect(outputFile.existsSync(), true);
    expect(
        ListEquality()
            .equals(matchFile.readAsBytesSync(), matchFile.readAsBytesSync()),
        true);

    outputFile.delete();
    outputTxtFile.delete();
  });
}
