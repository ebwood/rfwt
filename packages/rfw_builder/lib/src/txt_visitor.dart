import 'package:collection/collection.dart';
import 'package:rfw/formats.dart';

import 'package:rfw_builder/rfw_builder.dart';

class TxtVisitor extends SpecVisitor<StringSink> {
  TxtVisitor({this.indent = '  ', int depth = 0}) : _depth = depth;

  final String indent;
  int _depth = 0;

  String get _leadingIndent => indent * _depth;

  @override
  StringSink visitArgsReference(ArgsReference spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('args.${spec.parts.join(".")}');
    return output;
  }

  @override
  StringSink visitBoundArgsReference(BoundArgsReference spec,
      [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('args(${spec.arguments}).${spec.parts.join(".")}');
    return output;
  }

  @override
  StringSink visitBoundLoopReference(BoundLoopReference spec,
      [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('loop(${spec.value}).${spec.parts.join(".")}');
    return output;
  }

  @override
  StringSink visitBoundStateReference(BoundStateReference spec,
      [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('state^${spec.depth}.${spec.parts.join(".")}');
    return output;
  }

  @override
  StringSink visitConstructorCall(ConstructorCall spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('${spec.name}(');
    if (spec.arguments.isNotEmpty) {
      visitDynamicMap(spec.arguments, output, true);
    }
    output.write(')');
    return output;
  }

  @override
  StringSink visitDataReference(DataReference spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('data.${spec.parts.join(".")}');
    return output;
  }

  @override
  StringSink visitDynamicList(DynamicList spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('[');
    spec.forEachIndexed((index, element) {
      output.write(' ');
      visitObject(element, output);
      output.write(index != spec.length - 1 ? ',' : ' ');
    });
    output.write(']');
    return output;
  }

  @override
  StringSink visitDynamicMap(DynamicMap spec,
      [StringSink? context,
      bool withoutCurlyBraces = false,
      bool singleLine = false]) {
    final output = context ?? StringBuffer();

    if (spec.isEmpty) {
      output.write(withoutCurlyBraces ? '' : '{ }');
      return output;
    }

    // convert int/list to color format, like 0x00FF0000
    spec = spec.map((key, value) {
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

    _depth++;
    if (!withoutCurlyBraces) {
      output.write('{');
      if (singleLine) output.write(' ');
    }

    if (!singleLine) output.write('\n');

    for (var (index, MapEntry(:key, :value)) in spec.entries.indexed) {
      if (!singleLine) output.write(_leadingIndent);
      output.write('$key: ');
      visitObject(value, output);
      if (index != spec.length - 1 || !singleLine) output.write(',');
      if (!singleLine) output.write('\n');
    }

    _depth--;
    output.write(_leadingIndent);
    if (!withoutCurlyBraces) {
      if (singleLine) output.write(' ');
      output.write('}');
    }
    return output;
  }

  @override
  StringSink visitEventHandler(EventHandler spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('event "${spec.eventName}" ');
    visitDynamicMap(spec.eventArguments, output);
    return output;
  }

  @override
  StringSink visitFullyQualifiedWidgetName(FullyQualifiedWidgetName spec,
      [StringSink? context]) {
    final output = context ?? StringBuffer();
    visitLibraryName(spec.library, output);
    output.write(':${spec.widget}');
    return output;
  }

  @override
  StringSink visitImport(Import spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write("import ");
    visitLibraryName(spec.name, output);
    output.write(";\n");
    return output;
  }

  @override
  StringSink visitLibraryName(LibraryName spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write(spec.parts.join('.'));
    return output;
  }

  int _loopVariableLength = -1;
  @override
  StringSink visitLoop(Loop spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    _depth++;
    output.write('\n');
    output.write(_leadingIndent);
    _loopVariableLength++;
    output.write('...for loop$_loopVariableLength in ');
    visitObject(spec.input, output);
    output.write(':\n');
    _depth++;
    output.write(_leadingIndent);
    visitObject(spec.output, output);
    _loopVariableLength--;
    _depth--;
    _depth--;
    return output;
  }

  @override
  StringSink visitLoopReference(LoopReference spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('loop${spec.loop}');
    // output.write('loop${spec.loop}.${spec.parts.join(".")}');
    return output;
  }

  @override
  StringSink visitMissing(Missing spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('<missing>');
    return output;
  }

  @override
  StringSink visitOtherAnyEventHandler(AnyEventHandler spec,
      [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write(spec);
    return output;
  }

  @override
  StringSink visitOtherBlobNode(BlobNode spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write(spec);
    return output;
  }

  @override
  StringSink visitOtherReference(Reference spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('$spec: ${spec.parts.join('.')}');
    return output;
  }

  @override
  StringSink visitRemoteWidgetLibrary(RemoteWidgetLibrary spec,
      [StringSink? context]) {
    final output = context ?? StringBuffer();
    for (var element in spec.imports) {
      visitImport(element, output);
    }

    output.write('\n');

    for (var element in spec.widgets) {
      visitWidgetDeclaration(element, output);
    }
    return output;
  }

  @override
  StringSink visitSetStateHandler(SetStateHandler spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('set ${spec.stateReference} = ${spec.value}');
    return output;
  }

  @override
  StringSink visitStateReference(StateReference spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('state.${spec.parts.join(".")}');
    return output;
  }

  @override
  StringSink visitSwitch(Switch spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('switch ');
    visitObject(spec.input, output);
    output.write(' ');
    visitDynamicMap(
        spec.outputs.map(
            (key, value) => MapEntry(key == null ? 'default' : '$key', value)),
        output);
    return output;
  }

  @override
  StringSink visitWidgetBuilderArgReference(WidgetBuilderArgReference spec,
      [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('${spec.argumentName}.${spec.parts.join('.')}');
    return output;
  }

  @override
  StringSink visitWidgetBuilderDeclaration(WidgetBuilderDeclaration spec,
      [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('(${spec.argumentName}) => ');
    visitObject(spec.widget, output);
    return output;
  }

  @override
  StringSink visitWidgetDeclaration(WidgetDeclaration spec,
      [StringSink? context]) {
    final output = context ?? StringBuffer();
    output.write('widget ${spec.name}');
    if (spec.initialState != null) {
      output.write(' ');
      visitDynamicMap(spec.initialState!, output, false, true);
    }

    output.write(' = ');
    spec.root.accept(this, output);
    output.write(';\n\n');
    return output;
  }

  @override
  StringSink visitObject(Object? spec, [StringSink? context]) {
    final output = context ?? StringBuffer();
    if (spec is BlobNode) {
      return spec.accept(this, output);
    } else if (spec is DynamicMap) {
      return visitDynamicMap(spec, output);
    } else if (spec is DynamicList) {
      return visitDynamicList(spec, output);
    } else if (spec is String) {
      return output..write('"$spec"');
    } else {
      //int, double, bool, null
      return output..write(spec);
    }
  }

  _ColorValue _int2Color(int value) {
    return _ColorValue(
        '0x${value.toRadixString(16).toUpperCase().toUpperCase()}');
  }
}

class _ColorValue {
  final String color;
  _ColorValue(this.color);

  @override
  String toString() => color;
}
