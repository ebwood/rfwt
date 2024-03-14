import 'package:rfw/formats.dart';

abstract class Builder<T> {
  void update(void Function(Builder)? updates) {
    updates?.call(this);
  }

  T build();
}

abstract class Spec {
  R accept<R>(SpecVisitor<R> visitor, [R? context]);
}

abstract class SpecVisitor<R> {
  R visitDynamicList(DynamicList spec, [R? context]);

  R visitDynamicMap(DynamicMap spec, [R? context]);

  R visitLibraryName(LibraryName spec, [R? context]);

  R visitFullyQualifiedWidgetName(FullyQualifiedWidgetName spec, [R? context]);

  R visitMissing(Missing spec, [R? context]);

  R visitLoop(Loop spec, [R? context]);

  R visitSwitch(Switch spec, [R? context]);

  R visitConstructorCall(ConstructorCall spec, [R? context]);

  R visitWidgetBuilderDeclaration(WidgetBuilderDeclaration spec, [R? context]);

  R visitArgsReference(ArgsReference spec, [R? context]);

  R visitBoundArgsReference(BoundArgsReference spec, [R? context]);

  R visitDataReference(DataReference spec, [R? context]);

  R visitWidgetBuilderArgReference(WidgetBuilderArgReference spec,
      [R? context]);

  R visitLoopReference(LoopReference spec, [R? context]);

  R visitBoundLoopReference(BoundLoopReference spec, [R? context]);

  R visitStateReference(StateReference spec, [R? context]);

  R visitBoundStateReference(BoundStateReference spec, [R? context]);

  R visitEventHandler(EventHandler spec, [R? context]);

  R visitSetStateHandler(SetStateHandler spec, [R? context]);

  R visitImport(Import spec, [R? context]);

  R visitWidgetDeclaration(WidgetDeclaration spec, [R? context]);

  R visitRemoteWidgetLibrary(RemoteWidgetLibrary spec, [R? context]);

  R visitOtherReference(Reference spec, [R? context]);

  R visitOtherAnyEventHandler(AnyEventHandler spec, [R? context]);

  R visitOtherBlobNode(BlobNode spec, [R? context]);
}

abstract mixin class DefaultSpecVisitor<R> implements SpecVisitor<R> {
  R get defaultValue;

  @override
  R visitDynamicList(DynamicList spec, [R? context]) => defaultValue;

  @override
  R visitDynamicMap(DynamicMap spec, [R? context]) => defaultValue;

  @override
  R visitArgsReference(ArgsReference spec, [R? context]) => defaultValue;

  @override
  R visitBoundArgsReference(BoundArgsReference spec, [R? context]) =>
      defaultValue;

  @override
  R visitDataReference(DataReference spec, [R? context]) => defaultValue;

  @override
  R visitWidgetBuilderArgReference(WidgetBuilderArgReference spec,
          [R? context]) =>
      defaultValue;

  @override
  R visitLoopReference(LoopReference spec, [R? context]) => defaultValue;

  @override
  R visitBoundLoopReference(BoundLoopReference spec, [R? context]) =>
      defaultValue;

  @override
  R visitStateReference(StateReference spec, [R? context]) => defaultValue;

  @override
  R visitBoundStateReference(BoundStateReference spec, [R? context]) =>
      defaultValue;

  @override
  R visitEventHandler(EventHandler spec, [R? context]) => defaultValue;

  @override
  R visitSetStateHandler(SetStateHandler spec, [R? context]) => defaultValue;

  @override
  R visitImport(Import spec, [R? context]) => defaultValue;

  @override
  R visitWidgetDeclaration(WidgetDeclaration spec, [R? context]) =>
      defaultValue;

  @override
  R visitRemoteWidgetLibrary(RemoteWidgetLibrary spec, [R? context]) =>
      defaultValue;

  @override
  R visitOtherReference(Reference spec, [R? context]) => defaultValue;

  @override
  R visitOtherAnyEventHandler(AnyEventHandler spec, [R? context]) =>
      defaultValue;

  @override
  R visitOtherBlobNode(BlobNode spec, [R? context]) => defaultValue;

  @override
  R visitLibraryName(LibraryName spec, [R? context]) => defaultValue;

  @override
  R visitFullyQualifiedWidgetName(FullyQualifiedWidgetName spec,
          [R? context]) =>
      defaultValue;

  @override
  R visitMissing(Missing spec, [R? context]) => defaultValue;

  @override
  R visitLoop(Loop spec, [R? context]) => defaultValue;

  @override
  R visitSwitch(Switch spec, [R? context]) => defaultValue;

  @override
  R visitConstructorCall(ConstructorCall spec, [R? context]) => defaultValue;

  @override
  R visitWidgetBuilderDeclaration(WidgetBuilderDeclaration spec,
          [R? context]) =>
      defaultValue;
}
