import 'package:rfw/formats.dart';

void main() {
  print(visitDynamicList(
      ["hello", "world", "welcome to the crazy world wahahahah"]));
  return;
  const call = ConstructorCall('Container', {
    'color': 0xFFF44336,
    'child': ConstructorCall('Text', {
      'text':
          "'hello world, welcome to the crazy world wahahahahhahahafdafasdfsda!!'",
      'list': ["hello", "world", "welcome to the crazy world wahahahah"]
    })
  });
  final result = visitConstructorCall(call);
  print(result);
}

String indent = '  ';
String visitConstructorCall(ConstructorCall call) {
  // map的内容，决定了ConstructorCall是单行还是多行，规则：
  // 先简单一点来，假设这个ConstructorCall是最顶级的，也就是前面没有内容了; 所有值都是int/double/bool/String
  StringBuffer buffer = StringBuffer();

  // 添加参数
  List<String> arguments = [];
  call.arguments.forEach((key, value) {
    // if (value == null) {
    //   return;
    // }
    StringBuffer argumentsBuffer = StringBuffer();
    String keyString = '$key: ';
    argumentsBuffer.write(keyString);

    final lineString = visitObject(value);
    bool overLineLimit = checkOverLineLimit([keyString, lineString]);
    if (overLineLimit) {
      List<String> lines = lineString.split('\n');
      lines = [lines[0], ...lines.sublist(1).map((e) => '$indent$e')];
      argumentsBuffer.write(lines.join('\n'));
    } else {
      argumentsBuffer.write(lineString);
    }
    arguments.add(argumentsBuffer.toString());
  });

  String left = '${call.name}(';
  String right = ')';
  bool overLineLimit = checkOverLineLimit([left, arguments.join(', '), right]);

  buffer.write(left);
  if (overLineLimit) {
    buffer.write('\n');
    for (var e in arguments) {
      buffer.write('$indent$e,\n');
    }
  } else {
    buffer.write(arguments.join(', '));
  }

  buffer.write(right);
  return buffer.toString();
}

bool isSingleLine(String value) => !value.contains('\n');

bool checkOverLineLimit(List<String> value, {int limit = 80}) {
  return value.any((e) => e.contains('\n')) || value.join('').length > limit;
}

String visitObject(Object? value) {
  if (value == null) {
    return 'null';
  } else if (value is ConstructorCall) {
    return visitConstructorCall(value);
  } else if (value is DynamicList) {
    return visitDynamicList(value);
  } else if (value is String) {
    return '"$value"';
  }
  return '$value';
}

String visitDynamicList(DynamicList list) {
  List<String> arguments = [];

  for (var e in list) {
    StringBuffer argumentsBuffer = StringBuffer();
    final lineString = visitObject(e);
    if (checkOverLineLimit([lineString])) {
      // argumentsBuffer.write('\n');

      List<String> lines = lineString.split('\n');
      lines = lines.map((e) => '$indent$e').toList();

      argumentsBuffer.write(lines.join('\n'));
    } else {
      argumentsBuffer.write(lineString);
    }
    arguments.add(argumentsBuffer.toString());
  }

  StringBuffer buffer = StringBuffer();
  String left = '[';
  String right = ']';
  bool overLineLimit = checkOverLineLimit([left, arguments.join(', '), right]);

  buffer.write(left);
  if (overLineLimit) {
    buffer.write('\n');
    buffer.write(arguments.map((e) => '$indent$e').join(',\n'));
    // for (var e in arguments) {
    //   buffer.write('$indent$e,\n');
    // }
  } else {
    buffer.write(arguments.join(', '));
  }

  buffer.write(right);
  return buffer.toString();
}
