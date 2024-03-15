import 'dart:io';

import 'package:args/args.dart';

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
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Print the tool version.',
    )
    ..addOption('output', abbr: 'o', help: 'Output path.');
}

void printUsage(ArgParser argParser) {
  print('Usage: rfw2txt <flags> [arguments]');
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
      print('rfw2txt version: $version');
      return;
    }
    if (results.wasParsed('verbose')) {
      verbose = true;
    }

    if (verbose) {
      print('[VERBOSE] All arguments: ${results.arguments}');
    }

    String outputPath = '';
    if (results.wasParsed('output')) {
      outputPath = results['output'] as String;
    }

    // check if file exists
    String rfwPath = results.arguments[0];
    File rfwFile = File(rfwPath);
    if (!rfwFile.existsSync()) {
      print('File not found: $rfwPath');
      return;
    }

    String outputTxt = rfw2txt(rfwFile.readAsBytesSync());
    if (outputPath.isEmpty) {
      // no specific output path, print to console
      print(outputTxt);
    } else {
      // write to output file
      File outputFile = File(outputPath);
      outputFile.writeAsStringSync(rfw2txt(rfwFile.readAsBytesSync()));
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    printUsage(argParser);
  }
}
