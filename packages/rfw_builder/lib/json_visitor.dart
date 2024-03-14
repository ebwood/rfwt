// import 'package:rfw/src/dart/model.dart';
// import 'package:rfw_builder/base.dart';

// class JsonVisitor extends DefaultSpecVisitor<Map<String, dynamic>> {
//   @override
//   Map<String, dynamic> visitArgsReference(ArgsReference spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitArgsReference
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitBoundArgsReference(BoundArgsReference spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitBoundArgsReference
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitBoundLoopReference(BoundLoopReference spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitBoundLoopReference
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitBoundStateReference(BoundStateReference spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitBoundStateReference
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitConstructorCall(ConstructorCall spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitConstructorCall
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitDataReference(DataReference spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitDataReference
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitDynamicList(DynamicList spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitDynamicList
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitDynamicMap(DynamicMap spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitDynamicMap
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitEventHandler(EventHandler spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitEventHandler
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitFullyQualifiedWidgetName(FullyQualifiedWidgetName spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitFullyQualifiedWidgetName
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitImport(Import spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitImport
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitLibraryName(LibraryName spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitLibraryName
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitLoop(Loop spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitLoop
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitLoopReference(LoopReference spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitLoopReference
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitMissing(Missing spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitMissing
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitRemoteWidgetLibrary(RemoteWidgetLibrary spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitRemoteWidgetLibrary
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitSetStateHandler(SetStateHandler spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitSetStateHandler
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitStateReference(StateReference spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitStateReference
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitSwitch(Switch spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitSwitch
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitWidgetBuilderArgReference(WidgetBuilderArgReference spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitWidgetBuilderArgReference
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitWidgetBuilderDeclaration(WidgetBuilderDeclaration spec, [Map<String, dynamic>? context]) {
//     // TODO: implement visitWidgetBuilderDeclaration
//     throw UnimplementedError();
//   }

//   @override
//   Map<String, dynamic> visitWidgetDeclaration(WidgetDeclaration spec, [Map<String, dynamic>? context]) {
//     return {
//       'name': spec.name,
//       'type': '${spec.runtimeType}',
//       'root': spec.root.accept(this),
//     };
//   }
// }
