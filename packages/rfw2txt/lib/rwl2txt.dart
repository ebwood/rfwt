import 'package:rfw/formats.dart';

// Parse rwl to .rfwtxt
String rwl2txt(RemoteWidgetLibrary library) {
  return TxtVisitor().visit(library);
}

class TxtVisitor {
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
        return MapEntry(key, _int2Color(value));
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
        return object.map((e) => _int2Color(e as int)).toList().toString();
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

  String _int2Color(int value) {
    return '0x${value.toRadixString(16).toUpperCase().toUpperCase()}';
  }
}
