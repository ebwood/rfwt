import 'package:rfw/formats.dart';

import 'package:rfw_builder/rfw_builder.dart';

class TxtVisitor extends SpecVisitor<String, int> {
  TxtVisitor({this.indent = '  ', int depth = 0}) : _depth = depth;

  final String indent;
  int _depth = 0;

  String get _leadingIndent => indent * _depth;

  @override
  String visitArgsReference(ArgsReference spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write('args.${spec.parts.join(".")}');
    return output.toString();
  }

  @override
  String visitBoundArgsReference(BoundArgsReference spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write('args(${spec.arguments}).${spec.parts.join(".")}');
    return output.toString();
  }

  @override
  String visitBoundLoopReference(BoundLoopReference spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write('loop(${spec.value}).${spec.parts.join(".")}');
    return output.toString();
  }

  @override
  String visitBoundStateReference(BoundStateReference spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write('state^${spec.depth}.${spec.parts.join(".")}');
    return output.toString();
  }

  @override
  String visitConstructorCall(ConstructorCall spec,
      [String? context, int? params]) {
    final output = StringBuffer();

    String left = '${spec.name}(';
    String right = ')';

    int parentSpace = left.length + right.length + (params ?? 0);

    output.write(left);
    if (spec.arguments.isNotEmpty) {
      output.write(visitDynamicMap(spec.arguments, context, parentSpace, true));
    }
    output.write(')');

    return output.toString();
  }

  @override
  String visitDataReference(DataReference spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write('data.${spec.parts.join(".")}');
    return output.toString();
  }

  bool checkOverLineLimit(List<String> value, int parentSpace,
      {int limit = 80}) {
    return value.any((e) => e.contains('\n')) ||
        value.join('').length + parentSpace > limit;
  }

  StringBuffer joinLines(String start, String end, int parentSpace,
      List<String> lines, StringBuffer buffer) {
    bool overLineLimit =
        checkOverLineLimit([start, lines.join(', '), end], parentSpace);

    buffer.write(start);
    if (overLineLimit) {
      buffer.write('\n');
      lines = lines.map((e) {
        List<String> content = e.split('\n').map((e) => '$indent$e').toList();
        return content.join('\n');
      }).toList();

      buffer.write(lines.join(',\n'));
      buffer.write('\n');
    } else {
      buffer.write(lines.join(', '));
    }
    buffer.write(end);

    return buffer;
  }

  @override
  String visitDynamicList(DynamicList spec, [String? context, int? params]) {
    String start = '[';
    String end = ']';

    StringBuffer buffer = StringBuffer();
    int parentSpace = params ?? 0;
    List<String> arguments = spec
        .map((e) =>
            visitObject(e, context, parentSpace + start.length + end.length))
        .toList();

    joinLines(start, end, parentSpace, arguments, buffer);

    return buffer.toString();
  }

  @override
  String visitDynamicMap(DynamicMap spec,
      [String? context,
      int? params,
      bool withoutCurlyBraces = false,
      bool singleLine = false]) {
    int parentSpace = params ?? 0;

    StringBuffer buffer = StringBuffer();
    String start = withoutCurlyBraces ? '' : '{';
    String end = withoutCurlyBraces ? '' : '}';

    List<String> arguments = spec.entries.map((e) {
      String key = '${e.key}: ';
      String value = visitObject(e.value, context,
          parentSpace + start.length + end.length + key.length);
      return '$key$value';
    }).toList();

    joinLines(start, end, parentSpace, arguments, buffer);

    return buffer.toString();
  }

  @override
  String visitEventHandler(EventHandler spec, [String? context, int? params]) {
    final output = StringBuffer();
    output.write('event "${spec.eventName}" ');
    output.write(visitDynamicMap(spec.eventArguments, context, params));
    return output.toString();
  }

  @override
  String visitFullyQualifiedWidgetName(FullyQualifiedWidgetName spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write(visitLibraryName(spec.library, context, params));
    output.write(':${spec.widget}');
    return output.toString();
  }

  @override
  String visitImport(Import spec, [String? context, int? params]) {
    final output = StringBuffer();
    output.write("import ");
    output.write(visitLibraryName(spec.name, context, params));
    output.write(";\n");
    return output.toString();
  }

  @override
  String visitLibraryName(LibraryName spec, [String? context, int? params]) {
    final output = StringBuffer();
    output.write(spec.parts.join('.'));
    return output.toString();
  }

  int _loopVariableLength = -1;
  @override
  String visitLoop(Loop spec, [String? context, int? params]) {
    final output = StringBuffer();
    output.write('\n');
    output.write(_leadingIndent);
    _loopVariableLength++;
    output.write('...for loop$_loopVariableLength in ');
    output.write(visitObject(spec.input, context, params));
    output.write(':\n');
    _depth++;
    output.write(_leadingIndent);
    output.write(visitObject(spec.output, context, params));
    _loopVariableLength--;
    _depth--;
    return output.toString();
  }

  @override
  String visitLoopReference(LoopReference spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write('loop${spec.loop}');
    if (spec.parts.isNotEmpty) {
      output.write('.${spec.parts.join('.')}');
    }
    return output.toString();
  }

  @override
  String visitMissing(Missing spec, [String? context, int? params]) {
    final output = StringBuffer();
    output.write('<missing>');
    return output.toString();
  }

  @override
  String visitOtherAnyEventHandler(AnyEventHandler spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write(spec);
    return output.toString();
  }

  @override
  String visitOtherBlobNode(BlobNode spec, [String? context, int? params]) {
    final output = StringBuffer();
    output.write(spec);
    return output.toString();
  }

  @override
  String visitOtherReference(Reference spec, [String? context, int? params]) {
    final output = StringBuffer();
    output.write('$spec: ${spec.parts.join('.')}');
    return output.toString();
  }

  @override
  String visitRemoteWidgetLibrary(RemoteWidgetLibrary spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    for (var element in spec.imports) {
      output.write(visitImport(element, context, params));
    }

    output.write('\n');

    for (var element in spec.widgets) {
      output.write(visitWidgetDeclaration(element, context, 0));
    }
    return output.toString();
  }

  @override
  String visitSetStateHandler(SetStateHandler spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write('set ${spec.stateReference} = ${spec.value}');
    return output.toString();
  }

  @override
  String visitStateReference(StateReference spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write('state.${spec.parts.join(".")}');
    return output.toString();
  }

  @override
  String visitSwitch(Switch spec, [String? context, int? params]) {
    final output = StringBuffer();
    output.write('switch ');
    output.write(visitObject(spec.input, context, params));
    output.write(' ');
    output.write(visitDynamicMap(
        spec.outputs.map(
            (key, value) => MapEntry(key == null ? 'default' : '$key', value)),
        context,
        params));
    return output.toString();
  }

  @override
  String visitWidgetBuilderArgReference(WidgetBuilderArgReference spec,
      [String? context, int? params]) {
    final output = StringBuffer();
    output.write('${spec.argumentName}.${spec.parts.join('.')}');
    return output.toString();
  }

  @override
  String visitWidgetBuilderDeclaration(WidgetBuilderDeclaration spec,
      [String? context, int? params]) {
    StringBuffer output = StringBuffer();
    output.write('(${spec.argumentName}) => ');
    output.write(visitObject(spec.widget, context, params));
    return output.toString();
  }

  @override
  String visitWidgetDeclaration(WidgetDeclaration spec,
      [String? context, int? params]) {
    StringBuffer output = StringBuffer();
    // calculate for multiline
    String ownSpace = 'widget ${spec.name}';

    output.write(ownSpace);
    ownSpace += ' = ';
    if (spec.initialState != null) {
      output.write(' ');
      ownSpace += ' ';

      String rootSpace = '';
      if (spec.root is ConstructorCall) {
        // hacky to get ConstructorCall name
        rootSpace = '${(spec.root as ConstructorCall).name}(';
      } else if (spec.root is Switch) {
        // hacky to get Switch name, but input is not just like String?
        rootSpace = 'switch ${(spec.root as Switch).input} {';
      }

      String initialState = visitDynamicMap(
          spec.initialState!, context, ownSpace.length + rootSpace.length, false, true);

      output.write(initialState);
      if (initialState.contains('\n')) {
        ownSpace = '} = ';
      } else {
        ownSpace += initialState;
      }
    }

    output.write(' = ');

    output.write(visitObject(spec.root, context, ownSpace.length));
    output.write(';\n\n');
    return output.toString();
  }

  @override
  String visitObject(Object? spec, [String? context, int? params]) {
    if (spec is BlobNode) {
      return spec.accept(this, context, params);
    } else if (spec is DynamicMap) {
      return visitDynamicMap(spec, context, params);
    } else if (spec is DynamicList) {
      return visitDynamicList(spec, context, params);
    } else if (spec is String) {
      return '"$spec"';
    } else {
      //int, double, bool, null
      return '$spec';
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
