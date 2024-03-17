import 'dart:convert';
import 'dart:typed_data';

import 'package:rfw/formats.dart';

import 'package:rfw_builder/rfw_builder.dart';

// Parse .rfw to json
DynamicMap rfw2json(Uint8List bytes) {
  RemoteWidgetLibrary rwl = decodeLibraryBlob(bytes);
  return rwl2json(rwl);
}

// Parse RemoteWidgetLibrary to json
DynamicMap rwl2json(RemoteWidgetLibrary library) =>
    library.accept(JsonVisitor()) as DynamicMap;

extension DynamicMapExJson on DynamicMap {
  String pretty() {
    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(this);
  }
}

// convert value to rfw data txt
StringBuffer value2DataTxt(Object? value, [StringBuffer? buffer]) {
  buffer ??= StringBuffer();
  if (value == null) {
    // nothing
    return buffer;
  }

  if (value is String) {
    buffer.write('"$value"');
  } else if (value is DynamicMap) {
    buffer.write('{');
    for (var element in value.entries) {
      buffer.write(element.key);
      buffer.write(':');
      value2DataTxt(element.value, buffer);
      buffer.write(',');
    }
    buffer.write('}');
  } else if (value is DynamicList) {
    buffer.write('[');
    for (var element in value) {
      value2DataTxt(element, buffer);
      buffer.write(',');
    }
    buffer.write(']');
  } else {
    buffer.write(value);
  }
  return buffer;
}

class JsonVisitor extends SpecVisitor<dynamic, dynamic> {
  @override
  DynamicMap visitArgsReference(ArgsReference spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'parts': visitDynamicList(spec.parts),
    };
  }

  @override
  DynamicMap visitBoundArgsReference(BoundArgsReference spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'parts': visitDynamicList(spec.parts),
      'arguments': visitObject(spec.arguments),
    };
  }

  @override
  DynamicMap visitBoundLoopReference(BoundLoopReference spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'value': visitObject(spec.value),
      'parts': visitDynamicList(spec.parts),
    };
  }

  @override
  DynamicMap visitBoundStateReference(BoundStateReference spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'depth': spec.depth,
      'parts': visitDynamicList(spec.parts)
    };
  }

  @override
  DynamicMap visitConstructorCall(ConstructorCall spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'name': spec.name,
      'arguments': visitDynamicMap(spec.arguments),
    };
  }

  @override
  DynamicMap visitDataReference(DataReference spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'parts': visitDynamicList(spec.parts)
    };
  }

  @override
  DynamicList visitDynamicList(DynamicList spec, [context, params]) {
    return spec.map((e) => visitObject(e)).toList();
  }

  @override
  DynamicMap visitDynamicMap(DynamicMap spec,
      [context, params, bool withoutCurlyBraces = false, bool singleLine = false]) {
    return spec.map((key, value) => MapEntry(key, visitObject(value)));
  }

  @override
  DynamicMap visitEventHandler(EventHandler spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'eventName': spec.eventName,
      'eventArguments': visitDynamicMap(spec.eventArguments),
    };
  }

  @override
  DynamicMap visitFullyQualifiedWidgetName(FullyQualifiedWidgetName spec,
      [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'library': visitLibraryName(spec.library),
      'widget': spec.widget
    };
  }

  @override
  DynamicMap visitImport(Import spec, [context, params]) =>
      {'type': '${spec.runtimeType}', 'parts': visitLibraryName(spec.name)};

  @override
  DynamicMap visitLibraryName(LibraryName spec, [context, params]) =>
      {'type': '${spec.runtimeType}', 'parts': visitDynamicList(spec.parts)};

  @override
  DynamicMap visitLoop(Loop spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'input': visitObject(spec.input),
      'output': visitObject(spec.output),
    };
  }

  @override
  DynamicMap visitLoopReference(LoopReference spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'loop': spec.loop,
      'parts': visitDynamicList(spec.parts),
    };
  }

  @override
  DynamicMap visitMissing(Missing spec, [context, params]) {
    return {'type': '${spec.runtimeType}', 'value': spec.toString()};
  }

  @override
  visitObject(Object? spec, [context, params]) {
    if (spec is BlobNode) {
      return spec.accept(this);
    } else if (spec is DynamicList) {
      return visitDynamicList(spec);
    } else if (spec is DynamicMap) {
      return visitDynamicMap(spec);
    }
    return {
      'type': '${spec.runtimeType}',
      'value': '$spec',
    };
  }

  @override
  DynamicMap visitOtherAnyEventHandler(AnyEventHandler spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'value': '$spec',
    };
  }

  @override
  DynamicMap visitOtherBlobNode(BlobNode spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'value': '$spec',
    };
  }

  @override
  DynamicMap visitOtherReference(Reference spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'value': '$spec',
    };
  }

  @override
  DynamicMap visitRemoteWidgetLibrary(RemoteWidgetLibrary spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'imports': spec.imports.map((e) => visitImport(e)).toList(),
      'widgets': spec.widgets.map((e) => visitWidgetDeclaration(e)).toList(),
    };
  }

  @override
  DynamicMap visitSetStateHandler(SetStateHandler spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'stateReference': spec.stateReference.accept(this),
      'value': visitObject(spec.value),
    };
  }

  @override
  DynamicMap visitStateReference(StateReference spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'parts': visitDynamicList(spec.parts)
    };
  }

  @override
  DynamicMap visitSwitch(Switch spec, [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'input': visitObject(spec.input),
      'outputs': spec.outputs.map((key, value) =>
          MapEntry(key == null ? 'default' : '$key', visitObject(value))),
    };
  }

  @override
  DynamicMap visitWidgetBuilderArgReference(WidgetBuilderArgReference spec,
      [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'arguments': spec.argumentName,
      'parts': visitDynamicList(spec.parts)
    };
  }

  @override
  DynamicMap visitWidgetBuilderDeclaration(WidgetBuilderDeclaration spec,
      [context, params]) {
    return {
      'type': '${spec.runtimeType}',
      'argumentName': spec.argumentName,
      'widget': spec.widget.accept(this)
    };
  }

  @override
  DynamicMap visitWidgetDeclaration(WidgetDeclaration spec, [context, params]) {
    return {
      'name': spec.name,
      'type': '${spec.runtimeType}',
      'root': spec.root.accept(this)
    };
  }
}
