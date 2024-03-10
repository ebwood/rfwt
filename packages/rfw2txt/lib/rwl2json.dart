import 'package:rfw/formats.dart';

// Parse RemoteWidgetLibrary to json
Map<String, dynamic> rwl2json(RemoteWidgetLibrary library) {
  return JsonVisitor().visit(library);
}

// RemoteWidgetLibrary to json visitor
class JsonVisitor {
  Map<String, dynamic> visit(RemoteWidgetLibrary library) {
    return {
      'type': '$runtimeType',
      'imports': library.imports.map((e) => _visitImport(e)).toList(),
      'widgets':
          library.widgets.map((e) => _visitWidgetDeclaration(e)).toList(),
    };
  }

  String _visitImport(Import import) => 'import ${import.name}';

  Map<String, dynamic> _visitWidgetDeclaration(WidgetDeclaration declaration) {
    return {
      'name': declaration.name,
      'type': '${declaration.runtimeType}',
      'root': _visitBlobNode(declaration.root),
    };
  }

  Map<String, dynamic> _visitBlobNode(BlobNode node) {
    if (node is WidgetDeclaration) {
      return _visitWidgetDeclaration(node);
    } else if (node is ConstructorCall) {
      return _visitConstructorCall(node);
    } else if (node is Reference) {
      return _visitReference(node);
    } else if (node is AnyEventHandler) {
      return _visitAnyEventHandler(node);
    } else if (node is Switch) {
      return _visitSwitch(node);
    } else {
      return {
        'type': '$runtimeType',
      };
    }
  }

  Map<String, dynamic> _visitConstructorCall(ConstructorCall call) {
    return {
      'type': '${call.runtimeType}',
      'name': call.name,
      'arguments': _visitDynamicMap(call.arguments),
    };
  }

  Map<String, dynamic> _visitReference(Reference reference) {
    return {'type': '${reference.runtimeType}', 'parts': reference.toString()};
  }

  Map<String, dynamic> _visitSwitch(Switch sw) {
    return {
      'type': '${sw.runtimeType}',
      'input': _visitObject(sw.input),
      'outputs': sw.outputs.map((key, value) =>
          MapEntry(key == null ? 'default' : '$key', _visitObject(value))),
    };
  }

  List<Object?> _visitDynamicList(DynamicList list) {
    return list.map((e) => _visitObject(e)).toList();
  }

  Map<String, dynamic> _visitDynamicMap(DynamicMap map) {
    return map.map((key, value) {
      if (value is DynamicList) {
        return MapEntry(key, _visitObject(value));
      }
      return MapEntry(key, _visitObject(value));
    });
  }

  Map<String, dynamic> _visitAnyEventHandler(AnyEventHandler handler) {
    if (handler is EventHandler) {
      return {
        'type': '${handler.runtimeType}',
        'eventName': handler.eventName,
        'eventArguments': _visitDynamicMap(handler.eventArguments),
      };
    } else if (handler is SetStateHandler) {
      return {
        'type': '${handler.runtimeType}',
        'stateReference': _visitReference(handler.stateReference),
        'value': _visitObject(handler.value),
      };
    }
    return {
      'type': '${handler.runtimeType}',
    };
  }

  dynamic _visitObject(Object? e) {
    if (e is BlobNode) {
      return _visitBlobNode(e);
    } else if (e is DynamicMap) {
      return _visitDynamicMap(e);
    } else if (e is DynamicList) {
      return _visitDynamicList(e);
    }
    return {
      'type': '${e.runtimeType}',
      'value': e,
    };
  }

  String int2Color(int value) {
    return '0x${value.toRadixString(16).toUpperCase().toUpperCase()}';
  }
}
