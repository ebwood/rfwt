import 'package:rfw/formats.dart';

import 'base.dart';

extension DynamicMapEx on DynamicMap {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitDynamicMap(this, context, params);
  }
}

extension DynamicListEx on DynamicList {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitDynamicList(this, context, params);
  }
}

extension BlobNodeEx on BlobNode {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    switch (this) {
      case Missing():
        return visitor.visitMissing(this as Missing, context, params);
      case Loop():
        return visitor.visitLoop(this as Loop, context, params);
      case Switch():
        return visitor.visitSwitch(this as Switch, context, params);
      case ConstructorCall():
        return visitor.visitConstructorCall(
            this as ConstructorCall, context, params);
      case WidgetBuilderDeclaration():
        return visitor.visitWidgetBuilderDeclaration(
            this as WidgetBuilderDeclaration, context, params);
      case Reference():
        switch (this) {
          case ArgsReference():
            return visitor.visitArgsReference(
                this as ArgsReference, context, params);
          case BoundArgsReference():
            return visitor.visitBoundArgsReference(
                this as BoundArgsReference, context, params);
          case DataReference():
            return visitor.visitDataReference(
                this as DataReference, context, params);
          case WidgetBuilderArgReference():
            return visitor.visitWidgetBuilderArgReference(
                this as WidgetBuilderArgReference, context, params);
          case LoopReference():
            return visitor.visitLoopReference(
                this as LoopReference, context, params);
          case BoundLoopReference():
            return visitor.visitBoundLoopReference(
                this as BoundLoopReference, context, params);
          case StateReference():
            return visitor.visitStateReference(
                this as StateReference, context, params);
          case BoundStateReference():
            return visitor.visitBoundStateReference(
                this as BoundStateReference, context, params);
          default:
            // other custom reference
            return visitor.visitOtherReference(
                this as Reference, context, params);
        }
      case AnyEventHandler():
        switch (this) {
          case EventHandler():
            return visitor.visitEventHandler(
                this as EventHandler, context, params);
          case SetStateHandler():
            return visitor.visitSetStateHandler(
                this as SetStateHandler, context, params);
          default:
            // other custom event handler
            return visitor.visitOtherAnyEventHandler(
                this as AnyEventHandler, context, params);
        }
      case Import():
        return visitor.visitImport(this as Import, context, params);
      case WidgetDeclaration():
        return visitor.visitWidgetDeclaration(
            this as WidgetDeclaration, context, params);
      default:
        return visitor.visitOtherBlobNode(this, context, params);
    }
  }
}

/// LibraryName
class $LibraryName extends LibraryName implements Spec {
  const $LibraryName._(super.parts);
  factory $LibraryName([void Function(LibraryNameBuilder)? updates]) =>
      (LibraryNameBuilder()..update(updates)).build();

  @override
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitLibraryName(this, context, params);
  }
}

extension LibraryNameExtension on LibraryName {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitLibraryName(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitFullyQualifiedWidgetName(this, context, params);
  }
}

extension FullyQualifiedWidgetNameExtension on FullyQualifiedWidgetName {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitFullyQualifiedWidgetName(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitMissing(this, context, params);
  }
}

/// Loop
class $Loop extends Loop implements Spec {
  $Loop._(super.items, super.body);
  factory $Loop([void Function(LoopBuilder)? updates]) =>
      (LoopBuilder()..update(updates)).build();

  @override
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitLoop(this, context, params);
  }
}

extension LoopExtension on Loop {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitLoop(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitSwitch(this, context, params);
  }
}

extension SwitchExtension on Switch {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitSwitch(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitConstructorCall(this, context, params);
  }
}

extension ConstructorCallExtension on ConstructorCall {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitConstructorCall(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitWidgetBuilderDeclaration(this, context, params);
  }
}

extension WidgetBuilderDeclarationExtension on WidgetBuilderDeclaration {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitWidgetBuilderDeclaration(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitArgsReference(this, context, params);
  }
}

extension ArgsReferenceExtension on ArgsReference {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitArgsReference(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitBoundArgsReference(this, context, params);
  }
}

extension BoundArgsReferenceExtension on BoundArgsReference {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitBoundArgsReference(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitDataReference(this, context, params);
  }
}

extension DataReferenceExtension on DataReference {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitDataReference(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitWidgetBuilderArgReference(this, context, params);
  }
}

extension WidgetBuilderArgReferenceExtension on WidgetBuilderArgReference {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitWidgetBuilderArgReference(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitLoopReference(this, context, params);
  }
}

extension LoopReferenceExtension on LoopReference {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitLoopReference(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitBoundLoopReference(this, context, params);
  }
}

extension BoundLoopReferenceExtension on BoundLoopReference {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitBoundLoopReference(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitStateReference(this, context, params);
  }
}

extension StateReferenceExtension on StateReference {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitStateReference(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitBoundStateReference(this, context, params);
  }
}

extension BoundStateReferenceExtension on BoundStateReference {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitBoundStateReference(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitEventHandler(this, context, params);
  }
}

/// EventHandler
class $EventHandler extends EventHandler implements Spec {
  const $EventHandler._(super.eventName, super.eventArguments);
  factory $EventHandler([void Function(EventHandlerBuilder)? updates]) =>
      (EventHandlerBuilder()..update(updates)).build();

  @override
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitEventHandler(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitSetStateHandler(this, context, params);
  }
}

extension SetStateHandlerExt on SetStateHandler {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitSetStateHandler(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitImport(this, context, params);
  }
}

extension ImportExt on Import {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitImport(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitWidgetDeclaration(this, context, params);
  }
}

extension WidgetDeclarationExt on WidgetDeclaration {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitWidgetDeclaration(this, context, params);
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
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitRemoteWidgetLibrary(this, context, params);
  }
}

extension RemoteWidgetLibraryExt on RemoteWidgetLibrary {
  R accept<R, S>(SpecVisitor<R, S> visitor, [R? context, S? params]) {
    return visitor.visitRemoteWidgetLibrary(this, context, params);
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
