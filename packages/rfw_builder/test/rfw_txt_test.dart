import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:path/path.dart';
import 'package:rfw/formats.dart';
import 'package:test/test.dart';

void main() {
  test('rfw2txt with output path', () async {
    print('current: $current');
    File inputRfwFile = File('test/test.rfw');
    File outputTxtFile = File('test/output.rfwtxt');

    Process process = await Process.start('dart', [
      'run',
      'bin/rfw2txt.dart',
      inputRfwFile.path,
      "-o",
      outputTxtFile.path,
    ]);
    await process.stdout.transform(utf8.decoder).forEach(print);
    await process.stderr.transform(utf8.decoder).forEach(print);

    expect(outputTxtFile.existsSync(), true);

    Uint8List outputRfwBytes =
        encodeLibraryBlob(parseLibraryFile(outputTxtFile.readAsStringSync()));

    expect(
        ListEquality().equals(inputRfwFile.readAsBytesSync(), outputRfwBytes),
        true);

    outputTxtFile.delete();
  });

  test('txt2rfw with output path', () async {
    File inputTxtFile = File('test/test.rfwtxt');
    File outputRfwFile = File('test/output.rfw');
    File matchRfwFile = File('test/test.rfw');
    Process process = await Process.start('dart', [
      'run',
      'bin/txt2rfw.dart',
      inputTxtFile.path,
      "-o",
      outputRfwFile.path,
    ]);
    await process.stdout.transform(utf8.decoder).forEach(print);
    await process.stderr.transform(utf8.decoder).forEach(print);

    expect(outputRfwFile.existsSync(), true);
    expect(
        true,
        ListEquality().equals(
            matchRfwFile.readAsBytesSync(), outputRfwFile.readAsBytesSync()));

    outputRfwFile.delete();
  });
}
