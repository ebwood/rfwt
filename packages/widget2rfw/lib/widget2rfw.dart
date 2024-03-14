library widget2rfw;

import 'package:flutter/widgets.dart';

import 'package:rfw/rfw.dart';

import 'flutter/arguments_encoder.dart';

export 'flutter/arguments_encoder.dart';
export 'flutter/core_widgets.dart';
export 'flutter/material_widgets.dart';
export 'flutter/runtime.dart';

ConstructorCall widget2rfw(Widget widget) {
  return ArgumentEncoders.widget(widget)!;
}
