import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';
import 'package:rfw/formats.dart';

const String version = '0.0.1';

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
      print('rfw2txt version: $version');
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
    outputFile.writeAsStringSync(
        decodeLibraryBlob(rfwFile.readAsBytesSync()).visit(ParseTxtVisitor()));
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}

extension on RemoteWidgetLibrary {
  String visit(ParseTxtVisitor visitor) => visitor.visit(this);
}

class ParseTxtVisitor {
  String visit(RemoteWidgetLibrary library) {
    StringBuffer buffer = StringBuffer();
    // write imports
    buffer.writeln(library.imports.map(_visitImport).join('\n'));

    buffer.writeln();
    // write widget declarations
    for (var element in library.widgets) {
      buffer.writeln(_visitWidgetDeclaration(element));
    }
    return buffer.toString();
  }

  // visit import
  String _visitImport(Import import) => 'import ${import.name};';

  // visit widget declaration
  String _visitWidgetDeclaration(WidgetDeclaration widget) {
    StringBuffer buffer = StringBuffer();
    buffer.write('widget ${widget.name}');

    if (widget.initialState != null) {
      buffer.write(_visitDynamicMap(widget.initialState!));
    }

    buffer.write(' = ');
    buffer.write(_visitObject(widget.root));
    buffer.write(';');
    return buffer.toString();
  }

  // visit DynamicMap
  String _visitDynamicMap(DynamicMap map, {bool withoutCurlyBraces = false}) {
    StringBuffer buffer = StringBuffer();

    DynamicMap newMap = map.map((key, value) {
      if (value is int && key == 'color') {
        return MapEntry(key, int2Color(value));
      }
      return MapEntry(key, _visitObject(value, dynamicMapKey: key));
    });

    if (withoutCurlyBraces) {
      buffer
          .write(newMap.entries.map((e) => '${e.key}: ${e.value}').join(', '));
    } else {
      buffer.write(newMap);
    }
    return buffer.toString();
  }

  // visit DynamicList
  String _visitDynamicList(DynamicList list) =>
      list.map((e) => _visitObject(e)).toList().toString();

  // visit BlobNode
  String _visitBlobNode(BlobNode node) {
    StringBuffer buffer = StringBuffer();
    if (node is ConstructorCall) {
      // ConstructorCall ignore arguments' curly braces
      buffer.write('${node.name}(');
      buffer.write(_visitDynamicMap(node.arguments, withoutCurlyBraces: true));
      buffer.write(')');
    } else if (node is Switch) {
      buffer.write('switch ');
      buffer.write(_visitObject(node.input));
      buffer.write(' ');
      node.outputs.forEach((key, value) {});
      // TODO: Can key be another type?
      buffer.write(node.outputs.map((key, value) => MapEntry(
          key == null ? 'default' : '$key',
          _visitObject(value, dynamicMapKey: '$key'))));
    } else if (node is EventHandler) {
      buffer.write('event "${node.eventName}" ');
      buffer.write(_visitDynamicMap(node.eventArguments));
    } else {
      buffer.write(node.toString());
    }
    return buffer.toString();
  }

  // BlobNode, DynamicMap, DynamicList, int, double, bool, String, null
  String _visitObject(Object? object, {String? dynamicMapKey}) {
    if (object is BlobNode) {
      return _visitBlobNode(object);
    } else if (object is DynamicMap) {
      return _visitDynamicMap(object);
    } else if (object is DynamicList) {
      if (object.every((element) => element is int) &&
          dynamicMapKey == 'colors') {
        return object.map((e) => int2Color(e as int)).toList().toString();
      }
      return _visitDynamicList(object);
    }
    if (object is String) {
      return '"$object"';
    } else {
      //int, double, bool, null
      return '$object';
    }
  }

  String int2Color(int value) {
    return '0x${value.toRadixString(16).toUpperCase().toUpperCase()}';
  }
}
