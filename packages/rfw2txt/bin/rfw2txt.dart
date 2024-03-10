import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';
import 'package:rfw2txt/rfw2txt.dart';
import 'package:yaml/yaml.dart';

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
    bool verbose = false;

    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      String version = '0.0.1';
      try {
        File pubspecFile = File('pubspec.yaml');
        version = loadYaml(pubspecFile.readAsStringSync())['version'];
      } catch (e) {
        print(e);
      }

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

    if (results.arguments.isEmpty) {
      print('No rfw path provided.');
      printUsage(argParser);
      return;
    }

    // check if file exists
    String rfwPath = results.arguments[0];
    File rfwFile = File(rfwPath);
    if (!rfwFile.existsSync()) {
      print('File not found: $rfwPath');
      return;
    }

    if (outputPath.isEmpty) {
      outputPath = '${basenameWithoutExtension(rfwPath)}.rfwtxt';
    }
    File outputFile = File(outputPath);
    outputFile.writeAsStringSync(rfw2txt(rfwFile.readAsBytesSync()));
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
