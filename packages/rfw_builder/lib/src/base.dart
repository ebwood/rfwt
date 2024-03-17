import 'package:rfw/formats.dart';

abstract class Builder<T> {
  void update(void Function(Builder)? updates) {
    updates?.call(this);
  }

  T build();
}

abstract class Spec {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? param]);
}

abstract class SpecVisitor<R, S> {
  R visitObject(Object? spec, [R? context, S? params]);

  R visitDynamicList(DynamicList spec, [R? context, S? params]);

  R visitDynamicMap(DynamicMap spec,
      [R? context, S? params, bool withoutCurlyBraces = false, bool singleLine = false]);

  R visitLibraryName(LibraryName spec, [R? context, S? params]);

  R visitFullyQualifiedWidgetName(FullyQualifiedWidgetName spec, [R? context, S? params]);

  R visitMissing(Missing spec, [R? context, S? params]);

  R visitLoop(Loop spec, [R? context, S? params]);

  R visitSwitch(Switch spec, [R? context, S? params]);

  R visitConstructorCall(ConstructorCall spec, [R? context, S? params]);

  R visitWidgetBuilderDeclaration(WidgetBuilderDeclaration spec, [R? context, S? params]);

  R visitArgsReference(ArgsReference spec, [R? context, S? params]);

  R visitBoundArgsReference(BoundArgsReference spec, [R? context, S? params]);

  R visitDataReference(DataReference spec, [R? context, S? params]);

  R visitWidgetBuilderArgReference(WidgetBuilderArgReference spec,
      [R? context, S? params]);

  R visitLoopReference(LoopReference spec, [R? context, S? params]);

  R visitBoundLoopReference(BoundLoopReference spec, [R? context, S? params]);

  R visitStateReference(StateReference spec, [R? context, S? params]);

  R visitBoundStateReference(BoundStateReference spec, [R? context, S? params]);

  R visitEventHandler(EventHandler spec, [R? context, S? params]);

  R visitSetStateHandler(SetStateHandler spec, [R? context, S? params]);

  R visitImport(Import spec, [R? context, S? params]);

  R visitWidgetDeclaration(WidgetDeclaration spec, [R? context, S? params]);

  R visitRemoteWidgetLibrary(RemoteWidgetLibrary spec, [R? context, S? params]);

  R visitOtherReference(Reference spec, [R? context, S? params]);

  R visitOtherAnyEventHandler(AnyEventHandler spec, [R? context, S? params]);

  R visitOtherBlobNode(BlobNode spec, [R? context, S? params]);
}

mixin class DefaultSpecVisitor<R, S> implements SpecVisitor<R, S> {
  @override
  R visitArgsReference(ArgsReference spec, [R? context, S? params]) {
    // TODO: implement visitArgsReference
    throw UnimplementedError();
  }

  @override
  R visitBoundArgsReference(BoundArgsReference spec, [R? context, S? params]) {
    // TODO: implement visitBoundArgsReference
    throw UnimplementedError();
  }

  @override
  R visitBoundLoopReference(BoundLoopReference spec, [R? context, S? params]) {
    // TODO: implement visitBoundLoopReference
    throw UnimplementedError();
  }

  @override
  R visitBoundStateReference(BoundStateReference spec, [R? context, S? params]) {
    // TODO: implement visitBoundStateReference
    throw UnimplementedError();
  }

  @override
  R visitConstructorCall(ConstructorCall spec, [R? context, S? params]) {
    // TODO: implement visitConstructorCall
    throw UnimplementedError();
  }

  @override
  R visitDataReference(DataReference spec, [R? context, S? params]) {
    // TODO: implement visitDataReference
    throw UnimplementedError();
  }

  @override
  R visitDynamicList(DynamicList spec, [R? context, S? params]) {
    // TODO: implement visitDynamicList
    throw UnimplementedError();
  }

  @override
  R visitDynamicMap(DynamicMap spec,
      [R? context, S? params, bool withoutCurlyBraces = false, bool singleLine = false]) {
    // TODO: implement visitDynamicMap
    throw UnimplementedError();
  }

  @override
  R visitEventHandler(EventHandler spec, [R? context, S? params]) {
    // TODO: implement visitEventHandler
    throw UnimplementedError();
  }

  @override
  R visitFullyQualifiedWidgetName(FullyQualifiedWidgetName spec, [R? context, S? params]) {
    // TODO: implement visitFullyQualifiedWidgetName
    throw UnimplementedError();
  }

  @override
  R visitImport(Import spec, [R? context, S? params]) {
    // TODO: implement visitImport
    throw UnimplementedError();
  }

  @override
  R visitLibraryName(LibraryName spec, [R? context, S? params]) {
    // TODO: implement visitLibraryName
    throw UnimplementedError();
  }

  @override
  R visitLoop(Loop spec, [R? context, S? params]) {
    // TODO: implement visitLoop
    throw UnimplementedError();
  }

  @override
  R visitLoopReference(LoopReference spec, [R? context, S? params]) {
    // TODO: implement visitLoopReference
    throw UnimplementedError();
  }

  @override
  R visitMissing(Missing spec, [R? context, S? params]) {
    // TODO: implement visitMissing
    throw UnimplementedError();
  }

  @override
  R visitOtherAnyEventHandler(AnyEventHandler spec, [R? context, S? params]) {
    // TODO: implement visitOtherAnyEventHandler
    throw UnimplementedError();
  }

  @override
  R visitOtherBlobNode(BlobNode spec, [R? context, S? params]) {
    // TODO: implement visitOtherBlobNode
    throw UnimplementedError();
  }

  @override
  R visitOtherReference(Reference spec, [R? context, S? params]) {
    // TODO: implement visitOtherReference
    throw UnimplementedError();
  }

  @override
  R visitRemoteWidgetLibrary(RemoteWidgetLibrary spec, [R? context, S? params]) {
    // TODO: implement visitRemoteWidgetLibrary
    throw UnimplementedError();
  }

  @override
  R visitSetStateHandler(SetStateHandler spec, [R? context, S? params]) {
    // TODO: implement visitSetStateHandler
    throw UnimplementedError();
  }

  @override
  R visitStateReference(StateReference spec, [R? context, S? params]) {
    // TODO: implement visitStateReference
    throw UnimplementedError();
  }

  @override
  R visitSwitch(Switch spec, [R? context, S? params]) {
    // TODO: implement visitSwitch
    throw UnimplementedError();
  }

  @override
  R visitWidgetBuilderArgReference(WidgetBuilderArgReference spec,
      [R? context, S? params]) {
    // TODO: implement visitWidgetBuilderArgReference
    throw UnimplementedError();
  }

  @override
  R visitWidgetBuilderDeclaration(WidgetBuilderDeclaration spec, [R? context, S? params]) {
    // TODO: implement visitWidgetBuilderDeclaration
    throw UnimplementedError();
  }

  @override
  R visitWidgetDeclaration(WidgetDeclaration spec, [R? context, S? params]) {
    // TODO: implement visitWidgetDeclaration
    throw UnimplementedError();
  }

  @override
  R visitObject(Object? spec, [R? context, S? params]) {
    // TODO: implement visitObject
    throw UnimplementedError();
  }
}

extension DynamicMapX on DynamicMap {
  DynamicMap add({required String key, required dynamic value}) {
    addAll({key: value});
    return this;
  }
}
