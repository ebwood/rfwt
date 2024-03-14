import 'package:flutter/material.dart';

import 'package:rfw/rfw.dart';

abstract class DataSourceEncoder {
  /// Return the int, double, bool, or String value at the given path of the
  /// arguments to the widget.
  ///
  /// `T` must be one of [int], [double], [bool], or [String].
  ///
  /// If `T` does not match the type of the value obtained, then the method
  /// returns null.
  T? v<T extends Object>(List<Object> argsKey);

  /// Return true if the given key identifies a list, otherwise false.
  bool isList(List<Object> argsKey);

  /// Return the length of the list at the given path of the arguments to the
  /// widget.
  ///
  /// If the given path does not identify a list, returns zero.
  int length(List<Object> argsKey);

  /// Return true if the given key identifies a map, otherwise false.
  bool isMap(List<Object> argsKey);

  /// Build the child at the given key.
  ///
  /// If the node specified is not a widget, returns an [ErrorWidget].
  ///
  /// See also:
  ///
  ///  * [optionalChild], which returns null if the widget is missing.
  Widget child(List<Object> argsKey);

  /// Build the child at the given key.
  ///
  /// If the node specified is not a widget, returns null.
  ///
  /// See also:
  ///
  ///  * [child], which returns an [ErrorWidget] instead of null if the widget
  ///    is missing.
  Widget? optionalChild(List<Object> argsKey);

  /// Builds the children at the given key.
  ///
  /// If the node is missing, returns an empty list.
  ///
  /// If the node specified is not a list of widgets, returns a list with the
  /// non-widget nodes replaced by [ErrorWidget].
  List<Widget> childList(List<Object> argsKey);

  /// Builds the widget builder at the given key.
  ///
  /// If the node is not a widget builder, returns an [ErrorWidget].
  ///
  /// See also:
  ///
  ///  * [optionalBuilder], which returns null if the widget builder is missing.
  Widget builder(List<Object> argsKey, DynamicMap builderArg);

  /// Builds the widget builder at the given key.
  ///
  /// If the node is not a widget builder, returns null.
  ///
  /// See also:
  ///
  ///  * [builder], which returns an [ErrorWidget] instead of null if the widget
  ///    builder is missing.
  Widget? optionalBuilder(List<Object> argsKey, DynamicMap builderArg);

  /// Gets a [VoidCallback] event handler at the given key.
  ///
  /// If the node specified is an [AnyEventHandler] or a [DynamicList] of
  /// [AnyEventHandler]s, returns a callback that invokes the specified event
  /// handler(s), merging the given `extraArguments` into the arguments
  /// specified in each event handler. In the event of a key conflict (where
  /// both the arguments specified in the remote widget declaration and the
  /// argument provided to this method have the same name), the arguments
  /// specified here take precedence.
  static dynamic voidHandler(VoidCallback? callback) {
    if (callback == null) {
      return null;
    }
    throw 'Not implemented';
  }

  /// Gets an event handler at the given key.
  ///
  /// The event handler can be of any Function type, as specified by the type
  /// argument `T`.
  ///
  /// When this method is called, the second argument, `generator`, is invoked.
  /// The `generator` callback must return a function, which we will call
  /// _entrypoint_, that matches the signature of `T`. The `generator` callback
  /// receives an argument, which we will call `trigger`. The _entrypoint_
  /// function must call `trigger`, optionally passing it any extra arguments
  /// that should be merged into the arguments specified in each event handler.
  ///
  /// This is admittedly a little confusing. At its core, the problem is that
  /// this method cannot itself automatically create a function (_entrypoint_)
  /// of the right type (`T`), and therefore a callback (`generator`) that knows
  /// how to wrap a function body (`trigger`) in the right signature (`T`) is
  /// needed to actually build that function (_entrypoint_).
  static T? handler<S, T>(void Function(S)? callback) {
    if (callback == null) {
      return null;
    }
    throw 'Not implemented';
  }
}
