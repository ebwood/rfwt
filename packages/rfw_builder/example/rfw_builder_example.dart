import 'package:rfw_builder/rfw_builder.dart';

void main() {
  final library = $RemoteWidgetLibrary((b) => b
    ..imports.add($Import((b) =>
        b..name = $LibraryName((b) => b..parts.addAll(['hello', 'world']))))
    ..widgets.add($WidgetDeclaration((b) => b
      ..name = 'Counter'
      ..root = $ConstructorCall((b) => b
        ..name = 'Container'
        ..arguments.addAll({
          'color': 0xFF00FF00,
          'child': $ConstructorCall((b) => b
            ..name = 'Text'
            ..arguments = {'text': 'Welcome'})
        })))));
  print(library);
}
