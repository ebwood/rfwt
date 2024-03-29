import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';

import 'package:rfw_builder/rfw_txt.dart';
import 'version.dart';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    )
    ..addOption('output', abbr: 'o', help: 'Output path.');
}

void printUsage(ArgParser argParser) {
  print('Usage: txt2rfw <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);

    if (results.arguments.isEmpty) {
      printUsage(argParser);
      return;
    }

    bool verbose = false;

    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      print('txt2rfw version: $version');
      return;
    }

    if (results.wasParsed('verbose')) {
      verbose = true;
    }

    // Act on the arguments provided.
    if (verbose) {
      print('[VERBOSE] All arguments: ${results.arguments}');
    }

    String outputPath = '';
    if (results.wasParsed('output')) {
      outputPath = results['output'] as String;
    }

    // check if file exists
    String txtPath = results.arguments[0];
    File txtFile = File(txtPath);
    if (!txtFile.existsSync()) {
      print('File not found: $txtPath');
      return;
    }

    if (outputPath.isEmpty) {
      outputPath = '${basenameWithoutExtension(txtPath)}.rfw';
    }
    File outputFile = File(outputPath);
    outputFile.writeAsBytesSync(txt2rfw(txtFile.readAsStringSync()));
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    printUsage(argParser);
  }
}
