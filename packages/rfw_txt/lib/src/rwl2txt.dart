import 'package:collection/collection.dart';
import 'package:rfw/formats.dart';

// Parse RemoteWidgetLibrary to .rfwtxt
String rwl2txt(RemoteWidgetLibrary library) {
  return TxtVisitor().visit(library);
}

// int color to raw hex, should ignore quote for output
class ColorValue {
  final String color;
  ColorValue(this.color);

  @override
  String toString() => color;
}

// RemoteWidgetLibrary to .rfwtxt format visitor
class TxtVisitor {
  final String _indent = '  ';
  int _indentCount = 0;

  String get _leadingIndent => _indent * _indentCount;

  String visit(RemoteWidgetLibrary library) {
    StringBuffer buffer = StringBuffer();
    // write imports
    for (var element in library.imports) {
      _visitImport(element, buffer);
    }

    buffer.write('\n');
    // write widget declarations
    for (var element in library.widgets) {
      _visitWidgetDeclaration(element, buffer);
    }
    return buffer.toString();
  }

// visit import
  void _visitImport(Import import, StringBuffer buffer) {
    buffer.write('import ${import.name};\n');
  }

// visit widget declaration
  void _visitWidgetDeclaration(WidgetDeclaration widget, StringBuffer buffer) {
    buffer.write('widget ${widget.name}');

    if (widget.initialState != null) {
      buffer.write(' ');
      _visitDynamicMap(widget.initialState!, buffer, singleLine: true);
    }

    buffer.write(' = ');
    _visitObject(widget.root, buffer);
    buffer.write(';\n\n');
  }

// visit DynamicMap
  void _visitDynamicMap(DynamicMap map, StringBuffer buffer,
      {bool withoutCurlyBraces = false, bool singleLine = false}) {
    if (map.isEmpty) {
      buffer.write(withoutCurlyBraces ? '' : '{ }');
      return;
    }

    // convert int/list to color format, like 0x00FF0000
    map = map.map((key, value) {
      if (value is int && key == 'color') {
        return MapEntry(key, _int2Color(value));
      }
      if (value is DynamicList &&
          value.every((element) => element is int) &&
          key == 'colors') {
        return MapEntry(key, value.map((e) => _int2Color(e as int)).toList());
      }
      return MapEntry(key, value);
    });

    _indentCount++;
    if (!withoutCurlyBraces) {
      buffer.write('{');
      if (singleLine) buffer.write(' ');
    }
    // if (map.length == 1) {
    //   buffer.write('${map.entries.first.key}: ');
    //   _visitObject(map.entries.first.value, buffer);
    //   buffer.write(' ');
    // } else {
    if (!singleLine) buffer.write('\n');

    for (var (index, MapEntry(:key, :value)) in map.entries.indexed) {
      if (!singleLine) buffer.write(_leadingIndent);
      buffer.write('$key: ');
      _visitObject(value, buffer);
      if (index != map.length - 1 || !singleLine) buffer.write(',');
      if (!singleLine) buffer.write('\n');
    }
    // }
    _indentCount--;
    // if (map.length > 1) {
    buffer.write(_leadingIndent);
    // }
    if (!withoutCurlyBraces) {
      if (singleLine) buffer.write(' ');
      buffer.write('}');
    }
  }

// visit DynamicList
  void _visitDynamicList(DynamicList list, StringBuffer buffer) {
    buffer.write('[');
    list.forEachIndexed((index, element) {
      buffer.write(' ');
      _visitObject(element, buffer);
      if (index != list.length - 1) {
        buffer.write(',');
      } else {
        buffer.write(' ');
      }
    });
    buffer.write(']');
  }

// visit BlobNode
  void _visitBlobNode(BlobNode node, StringBuffer buffer) {
    if (node is ConstructorCall) {
      // ConstructorCall ignore arguments' curly braces
      buffer.write('${node.name}(');
      if (node.arguments.isNotEmpty) {
        _visitDynamicMap(node.arguments, buffer, withoutCurlyBraces: true);
        // buffer.write(_leadingIndent);
      }
      buffer.write(')');
    } else if (node is Switch) {
      buffer.write('switch ');
      _visitObject(node.input, buffer);
      buffer.write(' ');
      // TODO: Can key be another type?
      _visitDynamicMap(
          node.outputs.map((key, value) =>
              MapEntry(key == null ? 'default' : '$key', value)),
          buffer);
    } else if (node is EventHandler) {
      buffer.write('event "${node.eventName}" ');
      _visitDynamicMap(node.eventArguments, buffer);
    } else {
      buffer.write(node.toString());
    }
  }

// BlobNode, DynamicMap, DynamicList, int, double, bool, String, null
  void _visitObject(Object? object, StringBuffer buffer) {
    if (object is BlobNode) {
      return _visitBlobNode(object, buffer);
    } else if (object is DynamicMap) {
      return _visitDynamicMap(object, buffer);
    } else if (object is DynamicList) {
      return _visitDynamicList(object, buffer);
    } else if (object is String) {
      return buffer.write('"$object"');
    } else {
      //int, double, bool, null
      return buffer.write(object);
    }
  }

  ColorValue _int2Color(int value) {
    return ColorValue(
        '0x${value.toRadixString(16).toUpperCase().toUpperCase()}');
  }
}
