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
  R visitObject(Object? spec, [R? context]);

  R visitDynamicList(DynamicList spec, [R? context]);

  R visitDynamicMap(DynamicMap spec,
      [R? context, bool withoutCurlyBraces = false, bool singleLine = false]);

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

mixin class DefaultSpecVisitor<R> implements SpecVisitor<R> {
  @override
  R visitArgsReference(ArgsReference spec, [R? context]) {
    // TODO: implement visitArgsReference
    throw UnimplementedError();
  }

  @override
  R visitBoundArgsReference(BoundArgsReference spec, [R? context]) {
    // TODO: implement visitBoundArgsReference
    throw UnimplementedError();
  }

  @override
  R visitBoundLoopReference(BoundLoopReference spec, [R? context]) {
    // TODO: implement visitBoundLoopReference
    throw UnimplementedError();
  }

  @override
  R visitBoundStateReference(BoundStateReference spec, [R? context]) {
    // TODO: implement visitBoundStateReference
    throw UnimplementedError();
  }

  @override
  R visitConstructorCall(ConstructorCall spec, [R? context]) {
    // TODO: implement visitConstructorCall
    throw UnimplementedError();
  }

  @override
  R visitDataReference(DataReference spec, [R? context]) {
    // TODO: implement visitDataReference
    throw UnimplementedError();
  }

  @override
  R visitDynamicList(DynamicList spec, [R? context]) {
    // TODO: implement visitDynamicList
    throw UnimplementedError();
  }

  @override
  R visitDynamicMap(DynamicMap spec,
      [R? context, bool withoutCurlyBraces = false, bool singleLine = false]) {
    // TODO: implement visitDynamicMap
    throw UnimplementedError();
  }

  @override
  R visitEventHandler(EventHandler spec, [R? context]) {
    // TODO: implement visitEventHandler
    throw UnimplementedError();
  }

  @override
  R visitFullyQualifiedWidgetName(FullyQualifiedWidgetName spec, [R? context]) {
    // TODO: implement visitFullyQualifiedWidgetName
    throw UnimplementedError();
  }

  @override
  R visitImport(Import spec, [R? context]) {
    // TODO: implement visitImport
    throw UnimplementedError();
  }

  @override
  R visitLibraryName(LibraryName spec, [R? context]) {
    // TODO: implement visitLibraryName
    throw UnimplementedError();
  }

  @override
  R visitLoop(Loop spec, [R? context]) {
    // TODO: implement visitLoop
    throw UnimplementedError();
  }

  @override
  R visitLoopReference(LoopReference spec, [R? context]) {
    // TODO: implement visitLoopReference
    throw UnimplementedError();
  }

  @override
  R visitMissing(Missing spec, [R? context]) {
    // TODO: implement visitMissing
    throw UnimplementedError();
  }

  @override
  R visitOtherAnyEventHandler(AnyEventHandler spec, [R? context]) {
    // TODO: implement visitOtherAnyEventHandler
    throw UnimplementedError();
  }

  @override
  R visitOtherBlobNode(BlobNode spec, [R? context]) {
    // TODO: implement visitOtherBlobNode
    throw UnimplementedError();
  }

  @override
  R visitOtherReference(Reference spec, [R? context]) {
    // TODO: implement visitOtherReference
    throw UnimplementedError();
  }

  @override
  R visitRemoteWidgetLibrary(RemoteWidgetLibrary spec, [R? context]) {
    // TODO: implement visitRemoteWidgetLibrary
    throw UnimplementedError();
  }

  @override
  R visitSetStateHandler(SetStateHandler spec, [R? context]) {
    // TODO: implement visitSetStateHandler
    throw UnimplementedError();
  }

  @override
  R visitStateReference(StateReference spec, [R? context]) {
    // TODO: implement visitStateReference
    throw UnimplementedError();
  }

  @override
  R visitSwitch(Switch spec, [R? context]) {
    // TODO: implement visitSwitch
    throw UnimplementedError();
  }

  @override
  R visitWidgetBuilderArgReference(WidgetBuilderArgReference spec,
      [R? context]) {
    // TODO: implement visitWidgetBuilderArgReference
    throw UnimplementedError();
  }

  @override
  R visitWidgetBuilderDeclaration(WidgetBuilderDeclaration spec, [R? context]) {
    // TODO: implement visitWidgetBuilderDeclaration
    throw UnimplementedError();
  }

  @override
  R visitWidgetDeclaration(WidgetDeclaration spec, [R? context]) {
    // TODO: implement visitWidgetDeclaration
    throw UnimplementedError();
  }
  
  @override
  R visitObject(Object? spec, [R? context]) {
    // TODO: implement visitObject
    throw UnimplementedError();
  }
}
