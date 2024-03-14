import 'package:rfw/formats.dart';

import 'base.dart';

/// LibraryName
class $LibraryName extends LibraryName implements Spec {
  const $LibraryName._(super.parts);
  factory $LibraryName([void Function(LibraryNameBuilder)? updates]) =>
      (LibraryNameBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitLibraryName(this, context);
  }
}

extension LibraryNameExtension on LibraryName {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitLibraryName(this, context);
  }
}

/// LibraryNameBuilder
class LibraryNameBuilder implements Builder<LibraryName> {
  List<String> parts = [];

  @override
  void update(void Function(LibraryNameBuilder)? updates) {
    updates?.call(this);
  }

  @override
  $LibraryName build() {
    return $LibraryName._(parts);
  }
}

/// FullyQualifiedWidgetName
class $FullyQualifiedWidgetName extends FullyQualifiedWidgetName
    implements Spec {
  $FullyQualifiedWidgetName._(super.library, super.widget);
  factory $FullyQualifiedWidgetName(
          [void Function(FullyQualifiedWidgetNameBuilder)? updates]) =>
      (FullyQualifiedWidgetNameBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitFullyQualifiedWidgetName(this, context);
  }
}

extension FullyQualifiedWidgetNameExtension on FullyQualifiedWidgetName {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitFullyQualifiedWidgetName(this, context);
  }
}

/// FullyQualifiedWidgetNameBuilder
class FullyQualifiedWidgetNameBuilder
    implements Builder<FullyQualifiedWidgetName> {
  LibraryName? library;
  String? widget;

  @override
  $FullyQualifiedWidgetName build() {
    return $FullyQualifiedWidgetName._(library!, widget!);
  }

  @override
  void update(void Function(FullyQualifiedWidgetNameBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// Missing
extension MissingEx on Missing {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitMissing(this, context);
  }
}

/// Loop
class $Loop extends Loop implements Spec {
  $Loop._(super.items, super.body);
  factory $Loop([void Function(LoopBuilder)? updates]) =>
      (LoopBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitLoop(this, context);
  }
}

extension LoopExtension on Loop {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitLoop(this, context);
  }
}

/// LoopBuilder
class LoopBuilder implements Builder<Loop> {
  Object? input;
  Object? output;
  @override
  $Loop build() {
    return $Loop._(input!, output!);
  }

  @override
  void update(void Function(LoopBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// Switch
class $Switch extends Switch implements Spec {
  $Switch._(super.input, super.outputs);
  factory $Switch([void Function(SwitchBuilder)? updates]) =>
      (SwitchBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitSwitch(this, context);
  }
}

extension SwitchExtension on Switch {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitSwitch(this, context);
  }
}

/// SwitchBuilder
class SwitchBuilder implements Builder<Switch> {
  Object? input;
  Map<Object?, Object> outputs = {};
  @override
  $Switch build() {
    return $Switch._(input!, outputs);
  }

  @override
  void update(void Function(SwitchBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// ConstructorCall
class $ConstructorCall extends ConstructorCall implements Spec {
  $ConstructorCall._(super.name, super.arguments);
  factory $ConstructorCall([void Function(ConstructorCallBuilder)? updates]) =>
      (ConstructorCallBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitConstructorCall(this, context);
  }
}

extension ConstructorCallExtension on ConstructorCall {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitConstructorCall(this, context);
  }
}

/// ConstructorCallBuilder
class ConstructorCallBuilder implements Builder<ConstructorCall> {
  String? name;
  DynamicMap arguments = {};

  @override
  $ConstructorCall build() {
    return $ConstructorCall._(name!, arguments);
  }

  @override
  void update(void Function(ConstructorCallBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// WidgetBuilderDeclaration
class $WidgetBuilderDeclaration extends WidgetBuilderDeclaration
    implements Spec {
  const $WidgetBuilderDeclaration._(super.argumentName, super.widget);
  factory $WidgetBuilderDeclaration(
          [void Function(WidgetBuilderDeclarationBuilder)? updates]) =>
      (WidgetBuilderDeclarationBuilder()..update(updates)).build();
  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitWidgetBuilderDeclaration(this, context);
  }
}

extension WidgetBuilderDeclarationExtension on WidgetBuilderDeclaration {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitWidgetBuilderDeclaration(this, context);
  }
}

/// WidgetBuilderDeclarationBuilder
class WidgetBuilderDeclarationBuilder
    implements Builder<WidgetBuilderDeclaration> {
  String? argumentName;
  BlobNode? widget;

  @override
  $WidgetBuilderDeclaration build() {
    return $WidgetBuilderDeclaration._(argumentName!, widget!);
  }

  @override
  void update(void Function(WidgetBuilderDeclarationBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// ArgsReference
class $ArgsReference extends ArgsReference implements Spec {
  const $ArgsReference._(super.parts);
  factory $ArgsReference([void Function(ArgsReferenceBuilder)? updates]) =>
      (ArgsReferenceBuilder()..update(updates)).build();
  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitArgsReference(this, context);
  }
}

extension ArgsReferenceExtension on ArgsReference {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitArgsReference(this, context);
  }
}

/// ArgsReferenceBuilder
class ArgsReferenceBuilder implements Builder<ArgsReference> {
  List<Object> parts = [];
  @override
  $ArgsReference build() {
    return $ArgsReference._(parts);
  }

  @override
  void update(void Function(ArgsReferenceBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// BoundArgsReference
class $BoundArgsReference extends BoundArgsReference implements Spec {
  const $BoundArgsReference._(super.arguments, super.parts);
  factory $BoundArgsReference(
          [void Function(BoundArgsReferenceBuilder)? updates]) =>
      (BoundArgsReferenceBuilder()..update(updates)).build();
  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitBoundArgsReference(this, context);
  }
}

extension BoundArgsReferenceExtension on BoundArgsReference {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitBoundArgsReference(this, context);
  }
}

/// BoundArgsReferenceBuilder
class BoundArgsReferenceBuilder implements Builder<BoundArgsReference> {
  Object? arguments;
  List<Object> parts = [];
  @override
  $BoundArgsReference build() {
    return $BoundArgsReference._(arguments!, parts);
  }

  @override
  void update(void Function(BoundArgsReferenceBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// DataReference
class $DataReference extends DataReference implements Spec {
  const $DataReference._(super.parts);
  factory $DataReference([void Function(DataReferenceBuilder)? updates]) =>
      (DataReferenceBuilder()..update(updates)).build();
  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitDataReference(this, context);
  }
}

extension DataReferenceExtension on DataReference {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitDataReference(this, context);
  }
}

/// DataReferenceBuilder
class DataReferenceBuilder implements Builder<DataReference> {
  List<Object> parts = [];
  @override
  $DataReference build() {
    return $DataReference._(parts);
  }

  @override
  void update(void Function(DataReferenceBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// WidgetBuilderArgReference
class $WidgetBuilderArgReference extends WidgetBuilderArgReference
    implements Spec {
  const $WidgetBuilderArgReference._(super.argumentName, super.parts);
  factory $WidgetBuilderArgReference(
          [void Function(WidgetBuilderArgReferenceBuilder)? updates]) =>
      (WidgetBuilderArgReferenceBuilder()..update(updates)).build();
  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitWidgetBuilderArgReference(this, context);
  }
}

extension WidgetBuilderArgReferenceExtension on WidgetBuilderArgReference {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitWidgetBuilderArgReference(this, context);
  }
}

/// WidgetBuilderArgReferenceBuilder
class WidgetBuilderArgReferenceBuilder
    implements Builder<WidgetBuilderArgReference> {
  String? argumentName;
  List<Object> parts = [];
  @override
  $WidgetBuilderArgReference build() {
    return $WidgetBuilderArgReference._(argumentName!, parts);
  }

  @override
  void update(void Function(WidgetBuilderArgReferenceBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// LoopReference
class $LoopReference extends LoopReference implements Spec {
  const $LoopReference._(super.loop, super.parts);
  factory $LoopReference([void Function(LoopReferenceBuilder)? updates]) =>
      (LoopReferenceBuilder()..update(updates)).build();
  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitLoopReference(this, context);
  }
}

extension LoopReferenceExtension on LoopReference {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitLoopReference(this, context);
  }
}

/// LoopReferenceBuilder
class LoopReferenceBuilder implements Builder<LoopReference> {
  int loop = 0;
  List<Object> parts = [];
  @override
  $LoopReference build() {
    return $LoopReference._(loop, parts);
  }

  @override
  void update(void Function(LoopReferenceBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// BoundLoopReference
class $BoundLoopReference extends BoundLoopReference implements Spec {
  const $BoundLoopReference._(super.value, super.parts);
  factory $BoundLoopReference(
          [void Function(BoundLoopReferenceBuilder)? updates]) =>
      (BoundLoopReferenceBuilder()..update(updates)).build();
  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitBoundLoopReference(this, context);
  }
}

extension BoundLoopReferenceExtension on BoundLoopReference {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitBoundLoopReference(this, context);
  }
}

/// BoundLoopReferenceBuilder
class BoundLoopReferenceBuilder implements Builder<BoundLoopReference> {
  Object? value;
  List<Object> parts = [];
  @override
  $BoundLoopReference build() {
    return $BoundLoopReference._(value!, parts);
  }

  @override
  void update(void Function(BoundLoopReferenceBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// StateReference
class $StateReference extends StateReference implements Spec {
  const $StateReference._(super.parts);
  factory $StateReference([void Function(StateReferenceBuilder)? updates]) =>
      (StateReferenceBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitStateReference(this, context);
  }
}

extension StateReferenceExtension on StateReference {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitStateReference(this, context);
  }
}

/// StateReferenceBuilder
class StateReferenceBuilder implements Builder<StateReference> {
  List<Object> parts = [];
  @override
  $StateReference build() {
    return $StateReference._(parts);
  }

  @override
  void update(void Function(StateReferenceBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// BoundStateReference
class $BoundStateReference extends BoundStateReference implements Spec {
  const $BoundStateReference._(super.depth, super.parts);
  factory $BoundStateReference(
          [void Function(BoundStateReferenceBuilder)? updates]) =>
      (BoundStateReferenceBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitBoundStateReference(this, context);
  }
}

extension BoundStateReferenceExtension on BoundStateReference {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitBoundStateReference(this, context);
  }
}

/// BoundStateReferenceBuilder
class BoundStateReferenceBuilder implements Builder<BoundStateReference> {
  int depth = 0;
  List<Object> parts = [];
  @override
  $BoundStateReference build() {
    return $BoundStateReference._(depth, parts);
  }

  @override
  void update(void Function(BoundStateReferenceBuilder p1)? updates) {
    updates?.call(this);
  }
}

extension EventHandlerExtension on EventHandler {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitEventHandler(this, context);
  }
}

/// EventHandler
class $EventHandler extends EventHandler implements Spec {
  const $EventHandler._(super.eventName, super.eventArguments);
  factory $EventHandler([void Function(EventHandlerBuilder)? updates]) =>
      (EventHandlerBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitEventHandler(this, context);
  }
}

/// EventHandlerBuilder
class EventHandlerBuilder implements Builder<EventHandler> {
  String? eventName;
  DynamicMap eventArguments = {};
  @override
  $EventHandler build() {
    return $EventHandler._(eventName!, eventArguments);
  }

  @override
  void update(void Function(EventHandlerBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// SetStateHandler
class $SetStateHandler extends SetStateHandler implements Spec {
  const $SetStateHandler._(super.stateReference, super.value);
  factory $SetStateHandler([void Function(SetStateHandlerBuilder)? updates]) =>
      (SetStateHandlerBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitSetStateHandler(this, context);
  }
}

extension SetStateHandlerExt on SetStateHandler {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitSetStateHandler(this, context);
  }
}

/// SetStateHandlerBuilder
class SetStateHandlerBuilder implements Builder<SetStateHandler> {
  AnyStateReference? stateReference;
  Object? value;
  @override
  $SetStateHandler build() {
    return $SetStateHandler._(stateReference!, value!);
  }

  @override
  void update(void Function(SetStateHandlerBuilder)? updates) {
    updates?.call(this);
  }
}

/// Import
class $Import extends Import implements Spec {
  const $Import._(super.name);
  factory $Import([void Function(ImportBuilder)? updates]) =>
      (ImportBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitImport(this, context);
  }
}

extension ImportExt on Import {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitImport(this, context);
  }
}

/// ImportBuilder
class ImportBuilder implements Builder<Import> {
  LibraryName? name;

  @override
  $Import build() {
    return $Import._(name!);
  }

  @override
  void update(void Function(ImportBuilder)? updates) {
    updates?.call(this);
  }
}

/// WidgetDeclaration
class $WidgetDeclaration extends WidgetDeclaration implements Spec {
  $WidgetDeclaration._(super.name, super.initialState, super.root);
  factory $WidgetDeclaration(
          [void Function(WidgetDeclarationBuilder)? updates]) =>
      (WidgetDeclarationBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitWidgetDeclaration(this, context);
  }
}

extension WidgetDeclarationExt on WidgetDeclaration {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitWidgetDeclaration(this, context);
  }
}

/// WidgetDeclarationBuilder
class WidgetDeclarationBuilder implements Builder<WidgetDeclaration> {
  String? name;
  DynamicMap initialState = {};
  BlobNode? root;

  @override
  $WidgetDeclaration build() {
    return $WidgetDeclaration._(
        name!, initialState.isEmpty ? null : initialState, root!);
  }

  @override
  void update(void Function(WidgetDeclarationBuilder p1)? updates) {
    updates?.call(this);
  }
}

/// RemoteWidgetLibrary
class $RemoteWidgetLibrary extends RemoteWidgetLibrary implements Spec {
  const $RemoteWidgetLibrary._(super.imports, super.widgets);
  factory $RemoteWidgetLibrary(
          [void Function(RemoteWidgetLibraryBuilder)? updates]) =>
      (RemoteWidgetLibraryBuilder()..update(updates)).build();

  @override
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitRemoteWidgetLibrary(this, context);
  }
}

extension RemoteWidgetLibraryExt on RemoteWidgetLibrary {
  R accept<R>(SpecVisitor<R> visitor, [R? context]) {
    return visitor.visitRemoteWidgetLibrary(this, context);
  }
}

/// RemoteWidgetLibraryBuilder
class RemoteWidgetLibraryBuilder implements Builder<RemoteWidgetLibrary> {
  List<Import> imports = [];
  List<WidgetDeclaration> widgets = [];
  @override
  $RemoteWidgetLibrary build() {
    return $RemoteWidgetLibrary._(imports, widgets);
  }

  @override
  void update(void Function(RemoteWidgetLibraryBuilder p1)? updates) {
    updates?.call(this);
  }
}
