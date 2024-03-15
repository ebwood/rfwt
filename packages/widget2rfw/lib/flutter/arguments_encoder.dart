// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// There's a lot of <Object>[] lists in this file so to avoid making this
// file even less readable we relax our usual stance on verbose typing.
// ignore_for_file: always_specify_types

// This file is hand-formatted.

// ignore: unnecessary_import, see https://github.com/flutter/flutter/pull/138881

import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:rfw/rfw.dart';

import 'core_widgets.dart';
import 'material_widgets.dart';

// ignore: unnecessary_import
import 'dart:ui'
    show
        FontFeature; // TODO(ianh): https://github.com/flutter/flutter/issues/87235

/// Signature for methods that decode structured values from a [DataSource],
/// such as the static methods of [ArgumentEncoders].
///
/// Used to make some of the methods of that class extensible.
typedef ArgumentEncoder<S, T> = T Function(S source);

/// A map that does not allow null values.
class NotNullMap<K, V> extends MapBase<K, V> {
  final Map<K, V> _map = {};

  NotNullMap();

  factory NotNullMap.from(Map<K, V> map) {
    final notNullMap = NotNullMap<K, V>();
    map.forEach((key, value) {
      notNullMap[key] = value;
    });
    return notNullMap;
  }

  @override
  V? operator [](Object? key) => _map[key];

  @override
  void operator []=(K key, V value) {
    if (value == null) return;
    _map[key] = value;
  }

  @override
  void clear() => _map.clear();

  @override
  Iterable<K> get keys => _map.keys;

  @override
  V? remove(Object? key) => _map.remove(key);
}

/// A visitor for [Widget]s.
abstract class WidgetVisitor {
  ConstructorCall visit(Widget widget);
}

/// A set of methods for decoding structured values from a [DataSource].
///
/// Specifically, these methods decode types that are used by local widgets
/// (q.v. [createCoreWidgets]).
///
/// These methods take a [DataSource] and a `key`. The `key` is a path to the
/// part of the [DataSource] that the value should be read from. This may
/// identify a map, a list, or a leaf value, depending on the needs of the
/// method.
class ArgumentEncoders {
  const ArgumentEncoders._();

  /// This is a workaround for https://github.com/dart-lang/sdk/issues/47021
  // ignore: unused_field, constant_identifier_names
  static const ArgumentEncoders __ =
      ArgumentEncoders._(); // ignore: unused_field

  // (in alphabetical order)

  /// Decodes an [AlignmentDirectional] or [Alignment] object out of the
  /// specified map.
  ///
  /// If the map has `start` and `y` keys, then it is interpreted as an
  /// [AlignmentDirectional] with those values. Otherwise if it has `x` and `y`
  /// it's an [Alignment] with those values. Otherwise it returns null.
  static Map<String, double>? alignment(AlignmentGeometry? alignment) {
    if (alignment == null) {
      return null;
    }
    if (alignment is Alignment) {
      return {
        'x': alignment.x,
        'y': alignment.y,
      };
    } else if (alignment is AlignmentDirectional) {
      return {
        'start': alignment.start,
        'y': alignment.y,
      };
    }
    return {};
  }

  /// Decodes the specified map into a [BoxConstraints].
  ///
  /// The keys used are `minWidth`, `maxWidth`, `minHeight`, and `maxHeight`.
  /// Omitted keys are defaulted to 0.0 for minimums and infinity for maximums.
  static Map<String, dynamic>? boxConstraints(BoxConstraints? constraints) {
    if (constraints == null) return null;
    return {
      'minWidth': constraints.minWidth,
      'maxWidth': constraints.maxWidth,
      'minHeight': constraints.minHeight,
      'maxHeight': constraints.maxHeight,
    };
  }

  /// Returns a [BorderDirectional] from the specified list.
  ///
  /// The list is a list of values as interpreted by [borderSide]. An empty or
  /// missing list results in a null return value. The list should have one
  /// through four items. Extra items are ignored.
  ///
  /// The values are interpreted as follows:
  ///
  ///  * start: first value.
  ///  * top: second value, defaulting to same as start.
  ///  * end: third value, defaulting to same as start.
  ///  * bottom: fourth value, defaulting to same as top.
  static List<Map<String, dynamic>?>? border(BoxBorder? border) {
    if (border == null) return null;

    if (border is Border) {
      return [
        borderSide(border.left),
        borderSide(border.top),
        borderSide(border.right),
        borderSide(border.bottom),
      ];
    } else if (border is BorderDirectional) {
      return [
        borderSide(border.start),
        borderSide(border.top),
        borderSide(border.end),
        borderSide(border.bottom),
      ];
    }
    // TODO: custom border?
    return null;
  }

  /// Returns a [BorderRadiusDirectional] from the specified list.
  ///
  /// The list is a list of values as interpreted by [radius]. An empty or
  /// missing list results in a null return value. The list should have one
  /// through four items. Extra items are ignored.
  ///
  /// The values are interpreted as follows:
  ///
  ///  * topStart: first value.
  ///  * topEnd: second value, defaulting to same as topStart.
  ///  * bottomStart: third value, defaulting to same as topStart.
  ///  * bottomEnd: fourth value, defaulting to same as topEnd.
  static List<Map<String, dynamic>?>? borderRadius(
      BorderRadiusGeometry? borderRadiusGeometry) {
    if (borderRadiusGeometry == null) {
      return null;
    }

    final borderRadius = borderRadiusGeometry as BorderRadius;
    return [
      radius(borderRadius.topLeft),
      radius(borderRadius.topRight),
      radius(borderRadius.bottomLeft),
      radius(borderRadius.bottomRight),
    ];
  }

  /// Returns a [BorderSide] from the specified map.
  ///
  /// If the map is absent, returns null.
  ///
  /// Otherwise (even if it has no keys), the [BorderSide] is created from the
  /// keys `color` (see [color], defaults to black), `width` (a double, defaults
  /// to 1.0), and `style` (see [enumValue] for [BorderStyle], defaults to
  /// [BorderStyle.solid]).
  static Map<String, dynamic>? borderSide(BorderSide? borderSide) {
    if (borderSide == null) return null;
    return {
      'color': color(borderSide.color),
      'width': borderSide.width,
      'style': enumValue(borderSide.style),
    };
  }

  /// Returns a [BoxShadow] from the specified map.
  ///
  /// If the map is absent, returns null.
  ///
  /// Otherwise (even if it has no keys), the [BoxShadow] is created from the
  /// keys `color` (see [color], defaults to black), `offset` (see [offset],
  /// defaults to [Offset.zero]), `blurRadius` (double, defaults to zero), and
  /// `spreadRadius` (double, defaults to zero).
  static Map<String, dynamic>? boxShadow(Shadow? boxShadow) {
    if (boxShadow == null) return null;
    return {
      'color': color(boxShadow.color),
      'offset': offset(boxShadow.offset),
      'blurRadius': boxShadow.blurRadius,
      if (boxShadow is BoxShadow) 'spreadRadius': boxShadow.spreadRadius,
    };
  }

  /// Returns a [Color] from the specified integer.
  ///
  /// Returns null if it's not an integer; otherwise, passes it to the [
  /// Color] constructor.
  static int? color(Color? color) {
    if (color == null) {
      return null;
    }
    // return '0x${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    return color.value;
  }

  /// Returns a [ColorFilter] from the specified map.
  ///
  /// The `type` key specifies the kind of filter.
  ///
  /// A type of `linearToSrgbGamma` creates a [ColorFilter.linearToSrgbGamma].
  ///
  /// A type of `matrix` creates a [ColorFilter.matrix], parsing the `matrix`
  /// key as per [colorMatrix]). If there is no `matrix` key, returns null.
  ///
  /// A type of `mode` creates a [ColorFilter.mode], using the `color` key
  /// (see[color], defaults to black) and the `blendMode` key (see [enumValue] for
  /// [BlendMdoe], defaults to [BlendMode.srcOver])
  ///
  /// A type of `srgbToLinearGamma` creates a [ColorFilter.srgbToLinearGamma].
  ///
  /// If the type is none of these, but is not null, then the type is looked up
  /// in [colorFilterDecoders], and if an entry is found, this method defers to
  /// that callback.
  ///
  /// Otherwise, returns null.
  static Map<String, dynamic>? colorFilter(ColorFilter? colorFilter) {
    if (colorFilter == null) return null;
    // colorFilter._type is private, so use toString to get type
    String type = colorFilter.toString();
    if (type.startsWith('ColorFilter.linearToSrgbGamma')) {
      return {
        'type': 'linearToSrgbGamma',
      };
    } else if (type.startsWith('ColorFilter.srgbToLinearGamma')) {
      return {
        'type': 'srgbToLinearGamma',
      };
    } else if (type.startsWith('ColorFilter.matrix')) {
      String matrix =
          type.substring('ColorFilter.matrix('.length, type.length - 1);
      List<String> matrixList =
          matrix.substring(1, matrix.length - 1).split(', ');
      return NotNullMap.from({
        'type': 'matrix',
        'matrix': colorMatrix(matrixList),
      });
    } else if (type.startsWith('ColorFilter.mode')) {
      List<String> colorAndMode = type
          .substring('ColorFilter.mode('.length, type.length - 1)
          .split(', ');
      Color colorValue = Color(int.parse(colorAndMode[0]));
      BlendMode blendMode = BlendMode.values
          .firstWhere((element) => element.name == colorAndMode[1]);
      return {
        'type': 'mode',
        'color': color(colorValue),
        'blendMode': enumValue(blendMode),
      };
    } else {
      final encoder = colorFilterEncoders[colorFilter.runtimeType];
      if (encoder == null) return null;
      return encoder(colorFilter);
    }
  }

  /// Extension mechanism for [colorFilter].
  static final Map<Type, ArgumentEncoder<ColorFilter, Map<String, dynamic>?>>
      colorFilterEncoders =
      <Type, ArgumentEncoder<ColorFilter, Map<String, dynamic>?>>{};

  /// Returns a list of 20 doubles from the specified list.
  ///
  /// If the specified key does not identify a list, returns null instead.
  ///
  /// If the list has fewer than 20 entries or if any of the entries are not
  /// doubles, any entries that could not be obtained are replaced by zero.
  ///
  /// Used by [colorFilter] in the `matrix` mode.
  static List<double?>? colorMatrix(List<String>? list) {
    if (list == null) return null;
    return list.map((e) => double.tryParse(e)).toList();
  }

  /// Returns a [Color] from the specified integer.
  ///
  /// Returns black if it's not an integer; otherwise, passes it to the [
  /// Color] constructor.
  ///
  /// This is useful in situations where null is not acceptable, for example,
  /// when providing a decoder to [list]. Otherwise, prefer using [DataSource.v]
  /// directly.

  /// Returns a [Curve] from the specified string.
  ///
  /// The given key should specify a string. If that string matches one of the
  /// names of static curves defined in the [Curves] class, then that curve is
  /// returned. Otherwise, if the string was not null, and is present as a key
  /// in the [curveDecoders] map, then the matching decoder from that map is
  /// invoked. Otherwise, the default obtained from [AnimationDefaults.curveOf]
  /// is used (which is why a [BuildContext] is required).
  static dynamic curve(Curve? curve) {
    if (curve == null) return null;

    switch (curve) {
      case Curves.linear:
        return 'linear';
      case Curves.decelerate:
        return 'decelerate';
      case Curves.fastLinearToSlowEaseIn:
        return 'fastLinearToSlowEaseIn';
      case Curves.ease:
        return 'ease';
      case Curves.easeIn:
        return 'easeIn';
      case Curves.easeInToLinear:
        return 'easeInToLinear';
      case Curves.easeInSine:
        return 'easeInSine';
      case Curves.easeInQuad:
        return 'easeInQuad';
      case Curves.easeInCubic:
        return 'easeInCubic';
      case Curves.easeInQuart:
        return 'easeInQuart';
      case Curves.easeInQuint:
        return 'easeInQuint';
      case Curves.easeInExpo:
        return 'easeInExpo';
      case Curves.easeInCirc:
        return 'easeInCirc';
      case Curves.easeInBack:
        return 'easeInBack';
      case Curves.easeOut:
        return 'easeOut';
      case Curves.linearToEaseOut:
        return 'linearToEaseOut';
      case Curves.easeOutSine:
        return 'easeOutSine';
      case Curves.easeOutQuad:
        return 'easeOutQuad';
      case Curves.easeOutCubic:
        return 'easeOutCubic';
      case Curves.easeOutQuart:
        return 'easeOutQuart';
      case Curves.easeOutQuint:
        return 'easeOutQuint';
      case Curves.easeOutExpo:
        return 'easeOutExpo';
      case Curves.easeOutCirc:
        return 'easeOutCirc';
      case Curves.easeOutBack:
        return 'easeOutBack';
      case Curves.easeInOut:
        return 'easeInOut';
      case Curves.easeInOutSine:
        return 'easeInOutSine';
      case Curves.easeInOutQuad:
        return 'easeInOutQuad';
      case Curves.easeInOutCubic:
        return 'easeInOutCubic';
      case Curves.easeInOutCubicEmphasized:
        return 'easeInOutCubicEmphasized';
      case Curves.easeInOutQuart:
        return 'easeInOutQuart';
      case Curves.easeInOutQuint:
        return 'easeInOutQuint';
      case Curves.easeInOutExpo:
        return 'easeInOutExpo';
      case Curves.easeInOutCirc:
        return 'easeInOutCirc';
      case Curves.easeInOutBack:
        return 'easeInOutBack';
      case Curves.fastOutSlowIn:
        return 'fastOutSlowIn';
      case Curves.slowMiddle:
        return 'slowMiddle';
      case Curves.bounceIn:
        return 'bounceIn';
      case Curves.bounceOut:
        return 'bounceOut';
      case Curves.bounceInOut:
        return 'bounceInOut';
      case Curves.elasticIn:
        return 'elasticIn';
      case Curves.elasticOut:
        return 'elasticOut';
      case Curves.elasticInOut:
        return 'elasticInOut';
      default:
        final encoder = curveEncoders[curve.runtimeType];
        if (encoder != null) {
          return encoder(curve);
        }
        return null;
    }
  }

  /// Extension mechanism for [curve].
  ///
  /// The decoders must not return null.
  ///
  /// The given key will specify a string, which is known to not match any of
  /// the values in [Curves].
  static final Map<Type, ArgumentEncoder<Curve, Map<String, dynamic>?>>
      curveEncoders = <Type, ArgumentEncoder<Curve, Map<String, dynamic>?>>{};

  /// Returns a [Decoration] from the specified map.
  ///
  /// The `type` key specifies the kind of decoration.
  ///
  /// A type of `box` creates a [BoxDecoration] using the keys `color`
  /// ([color]), `image` ([decorationImage]), `border` ([border]),
  /// `borderRadius` ([borderRadius]), `boxShadow` (a [list] of [boxShadow]),
  /// `gradient` ([gradient]), `backgroundBlendMode` (an [enumValue] of [BlendMode]),
  /// and `shape` (an [enumValue] of [BoxShape]), these keys each corresponding to
  /// the properties of [BoxDecoration] with the same name.
  ///
  /// A type of `flutterLogo` creates a [FlutterLogoDecoration] using the keys
  /// `color` ([color], corresponds to [FlutterLogoDecoration.textColor]),
  /// `style` ([enumValue] of [FlutterLogoStyle], defaults to
  /// [FlutterLogoStyle.markOnly]), and `margin` ([edgeInsets], always with a
  /// left-to-right direction), the latter two keys corresponding to
  /// the properties of [FlutterLogoDecoration] with the same name.
  ///
  /// A type of `shape` creates a [ShapeDecoration] using the keys `color`
  /// ([color]), `image` ([decorationImage]), `gradient` ([gradient]), `shadows`
  /// (a [list] of [boxShadow]), and `shape` ([shapeBorder]), these keys each
  /// corresponding to the properties of [ShapeDecoration] with the same name.
  ///
  /// If the type is none of these, but is not null, then the type is looked up
  /// in [decorationDecoders], and if an entry is found, this method defers to
  /// that callback.
  ///
  /// Otherwise, returns null.
  static Map<String, dynamic>? decoration(Decoration? decoration) {
    if (decoration == null) return null;

    if (decoration is BoxDecoration) {
      return NotNullMap.from({
        'type': 'box',
        'color': color(decoration.color),
        'image': decorationImage(decoration.image),
        'border': border(decoration.border),
        'borderRadius': borderRadius(decoration.borderRadius),
        'boxShadow': list<BoxShadow, Map<String, dynamic>?>(
            decoration.boxShadow, boxShadow),
        'gradient': gradient(decoration.gradient),
        'backgroundBlendMode':
            enumValue<BlendMode>(decoration.backgroundBlendMode),
        'shape': enumValue<BoxShape>(decoration.shape),
      });
    } else if (decoration is FlutterLogoDecoration) {
      return NotNullMap.from({
        'type': 'flutterLogo',
        'color': color(decoration.textColor),
        'style': enumValue<FlutterLogoStyle>(decoration.style),
        'margin': edgeInsets(decoration.margin),
      });
    } else if (decoration is ShapeDecoration) {
      return NotNullMap.from({
        'type': 'shape',
        'color': color(decoration.color),
        'image': decorationImage(decoration.image),
        'gradient': gradient(decoration.gradient),
        'shadows': list<BoxShadow, Map<String, dynamic>?>(
            decoration.shadows, boxShadow),
        'shape': shapeBorder(decoration.shape),
      });
    }

    final encoder = decorationEncoders[decoration.runtimeType];
    if (encoder != null) {
      return encoder(decoration);
    }
    return null;
  }

  /// Extension mechanism for [decoration].
  static final Map<Type, ArgumentEncoder<Decoration, Map<String, dynamic>?>>
      decorationEncoders =
      <Type, ArgumentEncoder<Decoration, Map<String, dynamic>?>>{};

  /// Returns a [DecorationImage] from the specified map.
  ///
  /// The [DecorationImage.image] is determined by interpreting the same key as
  /// per [imageProvider]. If that method returns null, then this returns null
  /// also. Otherwise, the return value is used as the provider and additional
  /// keys map to the identically-named properties of [DecorationImage]:
  /// `onError` (must be an event handler; the payload map is augmented by an
  /// `exception` key that contains the text serialization of the exception and
  /// a `stackTrace` key that contains the stack trace, also as a string),
  /// `colorFilter` ([colorFilter]), `fit` ([enumValue] of [BoxFit]), `alignment`
  /// ([alignment], defaults to [Alignment.center]), `centerSlice` ([rect]),
  /// `repeat` ([enumValue] of [ImageRepeat], defaults to [ImageRepeat.noRepeat]),
  /// `matchTextDirection` (boolean, defaults to false).
  static Map<String, dynamic>? decorationImage(DecorationImage? image) {
    if (image == null) return null;
    final provider = imageProvider(image.image);
    return NotNullMap.from({
      ...?provider,
      // TODO: still not sure about this
      // 'onError': DataSourceEncoder.voidHandler(image.onError),
      'colorFilter': colorFilter(image.colorFilter),
      'fit': enumValue<BoxFit>(image.fit),
      'alignment': alignment(image.alignment),
      'centerSlice': rect(image.centerSlice),
      'repeat': enumValue<ImageRepeat>(image.repeat),
      'matchTextDirection': image.matchTextDirection,
      'scale': image.scale,
      'opacity': image.opacity,
      'filterQuality': enumValue<FilterQuality>(image.filterQuality),
      'invertColors': image.invertColors,
      'isAntiAlias': image.isAntiAlias,
    });
  }

  /// Returns a double from the specified double.
  ///
  /// Returns 0.0 if it's not a double.
  ///
  /// This is useful in situations where null is not acceptable, for example,
  /// when providing a decoder to [list]. Otherwise, prefer using [DataSource.v]
  /// directly.

  /// Returns a [Duration] from the specified integer.
  ///
  /// If it's not an integer, the default obtained from
  /// [AnimationDefaults.durationOf] is used (which is why a [BuildContext] is
  /// required).
  static int? duration(Duration? duration) {
    return duration?.inMilliseconds;
  }

  /// Returns an [EdgeInsetsDirectional] from the specified list.
  ///
  /// The list is a list of doubles. An empty or missing list results in a null
  /// return value. The list should have one through four items. Extra items are
  /// ignored.
  ///
  /// The values are interpreted as follows:
  ///
  ///  * start: first value.
  ///  * top: second value, defaulting to same as start.
  ///  * end: third value, defaulting to same as start.
  ///  * bottom: fourth value, defaulting to same as top.
  static List<double>? edgeInsets(EdgeInsetsGeometry? edgeInsets) {
    if (edgeInsets == null) {
      return null;
    }
    EdgeInsets insets = edgeInsets.resolve(null);
    return [insets.left, insets.top, insets.right, insets.bottom];
  }

  /// Returns one of the values of the specified enum `T`, from the specified string.
  ///
  /// The string must match the name of the enum value, excluding the enum type
  /// name (the part of its [toString] after the dot).
  ///
  /// The first argument must be the `values` list for that enum; this is the
  /// list of values that is searched.
  ///
  /// For example, `enumValue<TileMode>(TileMode.values, source, ['tileMode']) ??
  /// TileMode.clamp` reads the `tileMode` key of `source`, and looks for the
  /// first match in [TileMode.values], defaulting to [TileMode.clamp] if
  /// nothing matches; thus, the string `mirror` would return [TileMode.mirror].
  static String? enumValue<T>(T? key) {
    if (key == null) return null;
    return key.toString().split('.').last;
  }

  /// Returns a [FontFeature] from the specified map.
  ///
  /// The `feature` key is used as the font feature name (defaulting to the
  /// probably-useless private value "NONE"), and the `value` key is used as the
  /// value (defaulting to 1, which typically means "enabled").
  ///
  /// As this never returns null, it is possible to use it with [list].
  static Map<String, dynamic>? fontFeature(FontFeature? feature) {
    if (feature == null) return null;
    return NotNullMap.from(
        {'feature': feature.feature, 'value': feature.value});
  }

  /// Returns a [Gradient] from the specified map.
  ///
  /// The `type` key specifies the kind of gradient.
  ///
  /// A type of `linear` creates a [LinearGradient] using the keys `begin`
  /// ([alignment], defaults to [Alignment.centerLeft]), `end` ([alignment],
  /// defaults to [Alignment.centerRight]), `colors` ([list] of [colorOrBlack],
  /// defaults to a two-element list with black and white), `stops` ([list] of
  /// [doubleOrZero]), and `tileMode` ([enumValue] of [TileMode], defaults to
  /// [TileMode.clamp]), these keys each corresponding to the properties of
  /// [BoxDecoration] with the same name.
  ///
  /// A type of `radial` creates a [RadialGradient] using the keys `center`
  /// ([alignment], defaults to [Alignment.center]), `radius' (double, defaults
  /// to 0.5), `colors` ([list] of [colorOrBlack], defaults to a two-element
  /// list with black and white), `stops` ([list] of [doubleOrZero]), `tileMode`
  /// ([enumValue] of [TileMode], defaults to [TileMode.clamp]), `focal`
  /// (([alignment]), and `focalRadius` (double, defaults to zero), these keys
  /// each corresponding to the properties of [BoxDecoration] with the same
  /// name.
  ///
  /// A type of `linear` creates a [LinearGradient] using the keys `center`
  /// ([alignment], defaults to [Alignment.center]), `startAngle` (double,
  /// defaults to 0.0), `endAngle` (double, defaults to 2π), `colors` ([list] of
  /// [colorOrBlack], defaults to a two-element list with black and white),
  /// `stops` ([list] of [doubleOrZero]), and `tileMode` ([enumValue] of [TileMode],
  /// defaults to [TileMode.clamp]), these keys each corresponding to the
  /// properties of [BoxDecoration] with the same name.
  ///
  /// The `transform` property of these gradient classes is not supported.
  // TODO(ianh): https://github.com/flutter/flutter/issues/87208
  ///
  /// If the type is none of these, but is not null, then the type is looked up
  /// in [gradientDecoders], and if an entry is found, this method defers to
  /// that callback.
  ///
  /// Otherwise, returns null.
  static Map<String, dynamic>? gradient(Gradient? gradient) {
    if (gradient == null) return null;

    switch (gradient) {
      case LinearGradient():
        return NotNullMap.from({
          'type': 'linear',
          'begin': alignment(gradient.begin),
          'end': alignment(gradient.end),
          'colors': list<Color, dynamic>(gradient.colors, color),
          'stops': list<double, double>(gradient.stops),
          'tileMode': enumValue(gradient.tileMode)
        });
      case RadialGradient():
        return NotNullMap.from({
          'type': 'radial',
          'center': alignment(gradient.center),
          'colors': list<Color, dynamic>(gradient.colors, color),
          'stops': list<double, double>(gradient.stops),
          'tileMode': enumValue(gradient.tileMode),
          'focal': alignment(gradient.focal),
          'focalRadius': gradient.focalRadius
        });
      case SweepGradient():
        return NotNullMap.from({
          'type': 'sweep',
          'center': alignment(gradient.center),
          'startAngle': gradient.startAngle,
          'endAngle': gradient.endAngle,
          'colors': list<Color, dynamic>(gradient.colors, color),
          'stops': list<double, double>(gradient.stops),
          'tileMode': enumValue(gradient.tileMode),
        });
      default:
        final encoder = gradientEncoders[gradient.runtimeType];
        if (encoder == null) return null;
        return encoder(gradient);
    }
  }

  /// Extension mechanism for [gradient].
  static final Map<Type, ArgumentEncoder<Gradient, Map<String, dynamic>?>>
      gradientEncoders =
      <Type, ArgumentEncoder<Gradient, Map<String, dynamic>?>>{};

  /// Returns a [SliverGridDelegate] from the specified map.
  ///
  /// The `type` key specifies the kind of grid delegate.
  ///
  /// A type of `fixedCrossAxisCount` creates a
  /// [SliverGridDelegateWithFixedCrossAxisCount] using the keys
  /// `crossAxisCount`, `mainAxisSpacing`, `crossAxisSpacing`,
  /// `childAspectRatio`, and `mainAxisExtent`.
  ///
  /// A type of `maxCrossAxisExtent` creates a
  /// [SliverGridDelegateWithMaxCrossAxisExtent] using the keys
  /// maxCrossAxisExtent:`, `mainAxisSpacing`, `crossAxisSpacing`,
  /// `childAspectRatio`, and `mainAxisExtent`.
  ///
  /// The types (int or double) and defaults for these keys match the
  /// identically named arguments to the default constructors of those classes.
  ///
  /// If the type is none of these, but is not null, then the type is looked up
  /// in [gridDelegateDecoders], and if an entry is found, this method defers to
  /// that callback.
  ///
  /// Otherwise, returns null.
  static Map<String, dynamic>? gridDelegate(SliverGridDelegate? delegate) {
    if (delegate == null) return null;
    if (delegate is SliverGridDelegateWithFixedCrossAxisCount) {
      return NotNullMap.from({
        'type': 'fixedCrossAxisCount',
        'crossAxisCount': delegate.crossAxisCount,
        'mainAxisSpacing': delegate.mainAxisSpacing,
        'crossAxisSpacing': delegate.crossAxisSpacing,
        'childAspectRatio': delegate.childAspectRatio,
        'mainAxisExtent': delegate.mainAxisExtent
      });
    } else if (delegate is SliverGridDelegateWithMaxCrossAxisExtent) {
      return NotNullMap.from({
        'type': 'maxCrossAxisExtent',
        'maxCrossAxisExtent': delegate.maxCrossAxisExtent,
        'mainAxisSpacing': delegate.mainAxisSpacing,
        'crossAxisSpacing': delegate.crossAxisSpacing,
        'childAspectRatio': delegate.childAspectRatio,
        'mainAxisExtent': delegate.mainAxisExtent
      });
    }

    final encoder = gridDelegateEncoders[delegate.runtimeType];
    if (encoder == null) return null;
    return encoder(delegate);
  }

  /// TODO wombat: All this custom encoders should have a type for every specific class provided to user, let them provide the implementation
  ///
  /// Extension mechanism for [gridDelegate].
  static final Map<Type,
          ArgumentEncoder<SliverGridDelegate, Map<String, dynamic>?>>
      gridDelegateEncoders =
      <Type, ArgumentEncoder<SliverGridDelegate, Map<String, dynamic>?>>{};

  /// Returns an [IconData] from the specified map.
  ///
  /// If the map does not have an `icon` key that is an integer, returns null.
  ///
  /// Otherwise, returns an [IconData] with the [IconData.codePoint] set to the
  /// integer from the `icon` key, the [IconData.fontFamily] set to the string
  /// from the `fontFamily` key, and the [IconData.matchTextDirection] set to
  /// the boolean from the `matchTextDirection` key (defaulting to false).
  ///
  /// For Material Design icons (those from the [Icons] class), the code point
  /// can be obtained from the documentation for the icon, and the font family
  /// is `MaterialIcons`. For example, [Icons.chalet] would correspond to
  /// `{ icon: 0xe14f, fontFamily: 'MaterialIcons' }`.
  ///
  /// When building the release build of an application that uses the RFW
  /// package, because this method creates non-const [IconData] objects
  /// dynamically, the `--no-tree-shake-icons` option must be used.
  static Map<String, dynamic>? iconData(IconData? icon) {
    if (icon == null) return null;
    return NotNullMap.from({
      'icon': icon.codePoint,
      'fontFamily': icon.fontFamily,
      'matchTextDirection': icon.matchTextDirection
    });
  }

  /// Returns an [IconThemeData] from the specified map.
  ///
  /// If the map is absent, returns null.
  ///
  /// Otherwise (even if it has no keys), the [IconThemeData] is created from
  /// the following keys: 'color` ([color]), `opacity` (double), `size`
  /// (double).
  static Map<String, dynamic>? iconThemeData(IconThemeData? data) {
    if (data == null) return null;
    return NotNullMap.from({
      'color': data.color,
      'opacity': data.opacity,
      'size': data.size,
    });
  }

  /// Returns an [ImageProvider] from the specifed map.
  ///
  /// The `source` key of the specified map is controlling. It must be a string.
  /// If its value is one of the keys in [imageProviderDecoders], then the
  /// relevant decoder is invoked and its return value is used (even if it is
  /// null).
  ///
  /// Otherwise, if the `source` key gives an absolute URL (one with a scheme),
  /// then a [NetworkImage] with that URL is returned. Its scale is given by the
  /// `scale` key (double, defaults to 1.0).
  ///
  /// Otherwise, if the `source` key gives a relative URL (i.e. it can be parsed
  /// as a URL and has no scheme), an [AssetImage] with the name given by the
  /// `source` key is returned.
  ///
  /// Otherwise, if there is no `source` key in the map, or if that cannot be
  /// parsed as a URL (absolute or relative), null is returned.
  static Map<String, dynamic>? imageProvider(ImageProvider? provider) {
    if (provider == null) {
      return null;
    }
    if (provider is ResizeImage) {
      provider = provider.imageProvider;
    }

    if (provider is NetworkImage) {
      return <String, dynamic>{'source': provider.url, 'scale': provider.scale};
    } else if (provider is AssetImage) {
      return <String, dynamic>{'source': provider.assetName};
    }

    final encoder = imageProviderEncoders[provider.runtimeType];
    if (encoder != null) {
      return encoder(provider);
    }
    return null;
  }

  /// Extension mechanism for [imageProvider].
  static final Map<Type, ArgumentEncoder<ImageProvider, Map<String, dynamic>?>>
      imageProviderEncoders =
      <Type, ArgumentEncoder<ImageProvider, Map<String, dynamic>?>>{};

  /// Returns a [List] of `T` values from the specified list, using the given
  /// `decoder` to parse each value.
  ///
  /// If the list is absent _or empty_, returns null (not an empty list).
  ///
  /// Otherwise, returns a list with as many items as the specified list, with
  /// each entry in the list decoded using `decoder`.
  ///
  /// If `T` is non-nullable, the decoder must also be non-nullable.
  static List<T>? list<S, T>(List<S>? source,
      [ArgumentEncoder<S, T>? encoder]) {
    if (source == null || source.isEmpty) {
      return null;
    }

    return source
        .map((e) => encoder == null ? (e as T) : encoder.call(e))
        .toList();
  }

  /// Returns a [Locale] from the specified string.
  ///
  /// The string is split on hyphens ("-").
  ///
  /// If the string is null, returns null.
  ///
  /// If there is no hyphen in the list, uses the one-argument form of [
  /// Locale], passing the whole string.
  ///
  /// If there is one hyphen in the list, uses the two-argument form of [
  /// Locale], passing the parts before and after the hyphen respectively.
  ///
  /// If there are two or more hyphens, uses the [Locale.fromSubtags]
  /// constructor.
  static String? locale(Locale? locale) {
    if (locale == null) return null;
    List<String?> list = [
      locale.languageCode,
      locale.scriptCode,
      locale.countryCode
    ]..removeWhere((element) => element != null);
    return list.join('-');
  }

  /// Returns a list of 16 doubles from the specified list.
  ///
  /// If the list is missing or has fewer than 16 entries, returns null.
  ///
  /// Otherwise, returns a list of 16 entries, corresponding to the first 16
  /// entries of the specified list, with any non-double values replaced by 0.0.
  static List<double>? matrix(Matrix4? matrix) {
    if (matrix == null) return null;

    return matrix.storage;
  }

  /// Returns a [MaskFilter] from the specified map.
  ///
  /// The `type` key specifies the kind of mask filter.
  ///
  /// A type of `blur` creates a [MaskFilter.blur]. The `style` key ([enumValue] of
  /// [BlurStyle], defaults to [BlurStyle.normal]) is used as the blur style,
  /// and the `sigma` key (double, defaults to 1.0) is used as the blur sigma.
  ///
  /// If the type is none of these, but is not null, then the type is looked up
  /// in [maskFilterDecoders], and if an entry is found, this method defers to
  /// that callback.
  ///
  /// Otherwise, returns null.
  static Map<String, dynamic>? maskFilter(MaskFilter? filter) {
    if (filter == null) return null;
    String type = filter.toString();
    if (type.startsWith('MaskFilter.blur(')) {
      List<String> parts = type.split(', ');
      return {
        'type': 'blur',
        'style': parts[0],
        'sigma': parts[1],
      };
    } else {
      final encoder = maskFilterEncoders[filter.runtimeType];
      if (encoder != null) {
        return encoder(filter);
      }
      return null;
    }
  }

  /// Extension mechanism for [maskFilter].
  static final Map<Type, ArgumentEncoder<MaskFilter, Map<String, dynamic>>>
      maskFilterEncoders =
      <Type, ArgumentEncoder<MaskFilter, Map<String, dynamic>>>{};

  /// Returns an [Offset] from the specified map.
  ///
  /// The map must have an `x` key and a `y` key, doubles.
  static Map<String, dynamic>? offset(Offset? offset) {
    if (offset == null) return null;
    return {'x': offset.dx, 'y': offset.dy};
  }

  /// Returns a [Paint] from the specified map.
  ///
  /// If the map is absent, returns null.
  ///
  /// Otherwise (even if it has no keys), a new [Paint] is created and its
  /// properties are set according to the identically-named properties of the
  /// map, as follows:
  ///
  ///  * `blendMode`: [enumValue] of [BlendMode].
  ///  * `color`: [color].
  ///  * `colorFilter`: [colorFilter].
  ///  * `filterQuality`: [enumValue] of [FilterQuality].
  //  * `imageFilter`: [imageFilter].
  //  * `invertColors`: boolean.
  ///  * `isAntiAlias`: boolean.
  ///  * `maskFilter`: [maskFilter].
  ///  * `shader`: [shader].
  //  * `strokeCap`: [enumValue] of [StrokeCap].
  //  * `strokeJoin`: [enumValue] of [StrokeJoin].
  //  * `strokeMiterLimit`: double.
  //  * `strokeWidth`: double.
  //  * `style`: [enumValue] of [PaintingStyle].
  ///
  /// (Some values are not supported, because there is no way for them to be
  /// used currently in RFW contexts.)
  static Map<String, dynamic>? paint(Paint? paint) {
    if (paint == null) return null;
    return NotNullMap.from({
      'blendMode': enumValue(paint.blendMode),
      'color': color(paint.color),
      'colorFilter': colorFilter(paint.colorFilter),
      'filterQuality': enumValue(paint.filterQuality),
      // TODO: rfw not support imageFilter
      // 'imageFilter': imageFilter(paint.imageFilter),
      'invertColors': paint.invertColors,
      'isAntiAlias': paint.isAntiAlias,
      'maskFilter': maskFilter(paint.maskFilter),
      'shader': shader(paint.shader),
      'strokeCap': enumValue(paint.strokeCap),
      'strokeJoin': enumValue(paint.strokeJoin),
      'strokeMiterLimit': paint.strokeMiterLimit,
      'strokeWidth': paint.strokeWidth,
      'style': enumValue(paint.style),
    });
  }

  /// Returns a [Radius] from the specified map.
  ///
  /// The map must have an `x` value corresponding to [Radius.x], and may have a
  /// `y` value corresponding to [Radius.y].
  ///
  /// If the map only has an `x` key, the `y` value is assumed to be the same
  /// (as in [Radius.circular]).
  ///
  /// If the `x` key is absent, the returned value is null.
  static Map<String, double>? radius(Radius? radius) {
    if (radius == null) return null;
    return {
      'x': radius.x,
      'y': radius.y,
    };
  }

  /// Returns a [Rect] from the specified map.
  ///
  /// If the map is absent, returns null.
  ///
  /// Otherwise, returns a [Rect.fromLTWH] whose x, y, width, and height
  /// components are determined from the `x`, `y`, `w`, and `h` properties of
  /// the map, with missing (or non-double) values replaced by zeros.
  static Map<String, dynamic>? rect(Rect? rect) {
    if (rect == null) return null;
    return {'x': rect.left, 'y': rect.top, 'w': rect.width, 'h': rect.height};
  }

  /// Returns a [ShapeBorder] from the specified map or list.
  ///
  /// If the key identifies a list, then each entry in the list is decoded by
  /// recursively invoking [shapeBorder], and the result is the combination of
  /// those [ShapeBorder] values as obtained using the [ShapeBorder.+] operator.
  ///
  /// Otherwise, if the key identifies a map with a `type` value, the map is
  /// interpreted according to the `type` as follows:
  ///
  ///  * `box`: the map's `sides` key is interpreted as a list by [border] and
  ///     the resulting [BoxBorder] (actually, [BorderDirectional]) is returned.
  ///
  ///  * `beveled`: a [BeveledRectangleBorder] is returned; the `side` key is
  ///    interpreted by [borderSide] to set the [BeveledRectangleBorder.side]
  ///    (default of [BorderSide.none)), and the `borderRadius` key is
  ///    interpreted by [borderRadius] to set the
  ///    [BeveledRectangleBorder.borderRadius] (default [BorderRadius.zero]).
  ///
  ///  * `circle`: a [CircleBorder] is returned; the `side` key is interpreted
  ///    by [borderSide] to set the [BeveledRectangleBorder.side] (default of
  ///    [BorderSide.none)).
  ///
  ///  * `continuous`: a [ContinuousRectangleBorder] is returned; the `side` key
  ///    is interpreted by [borderSide] to set the [BeveledRectangleBorder.side]
  ///    (default of [BorderSide.none)), and the `borderRadius` key is
  ///    interpreted by [borderRadius] to set the
  ///    [BeveledRectangleBorder.borderRadius] (default [BorderRadius.zero]).
  ///
  ///  * `rounded`: a [RoundedRectangleBorder] is returned; the `side` key is
  ///    interpreted by [borderSide] to set the [BeveledRectangleBorder.side]
  ///    (default of [BorderSide.none)), and the `borderRadius` key is
  ///    interpreted by [borderRadius] to set the
  ///    [BeveledRectangleBorder.borderRadius] (default [BorderRadius.zero]).
  ///
  ///  * `stadium`: a [StadiumBorder] is returned; the `side` key is interpreted
  ///    by [borderSide] to set the [BeveledRectangleBorder.side] (default of
  ///    [BorderSide.none)).
  ///
  /// If the type is none of these, then the type is looked up in
  /// [shapeBorderDecoders], and if an entry is found, this method defers to
  /// that callback.
  ///
  /// Otherwise, if type is null or is not found in [shapeBorderDecoders], returns null.
  static Map<String, dynamic>? shapeBorder(ShapeBorder? shapeBorder) {
    if (shapeBorder == null) return null;

    switch (shapeBorder) {
      case Border():
        return NotNullMap.from({
          'type': 'box',
          'sides': border(shapeBorder),
        });
      case BeveledRectangleBorder():
        return NotNullMap.from({
          'type': 'beveled',
          'side': borderSide(shapeBorder.side),
          'borderRadius': borderRadius(shapeBorder.borderRadius),
        });
      case CircleBorder():
        return NotNullMap.from(
            {'type': 'circle', 'side': borderSide(shapeBorder.side)});
      case ContinuousRectangleBorder():
        return NotNullMap.from({
          'type': 'continuous',
          'size': borderSide(shapeBorder.side),
          'borderRadius': borderRadius(shapeBorder.borderRadius)
        });
      case StadiumBorder():
        return NotNullMap.from(
            {'type': 'stadium', 'side': borderSide(shapeBorder.side)});
      default:
        final encoder = shapeBorderEncoders[shapeBorder.runtimeType];
        if (encoder == null) return null;
        return encoder(shapeBorder);
    }
  }

  /// Extension mechanism for [shapeBorder].
  static final Map<Type, ArgumentEncoder<ShapeBorder, Map<String, dynamic>?>>
      shapeBorderEncoders =
      <Type, ArgumentEncoder<ShapeBorder, Map<String, dynamic>?>>{};

  /// Returns a [Shader] based on the specified map.
  ///
  /// The `type` key specifies the kind of shader.
  ///
  /// A type of `linear`, `radial`, or `sweep` is interpreted as described by
  /// [gradient]; then, the gradient is compiled to a shader by applying the
  /// `rect` (interpreted by [rect]) and `textDirection` (interpreted as an
  /// [enumValue] of [TextDirection]) using the [Gradient.createShader] method.
  ///
  /// If the type is none of these, but is not null, then the type is looked up
  /// in [shaderDecoders], and if an entry is found, this method defers to
  /// that callback.
  ///
  /// Otherwise, returns null.
  static Map<String, dynamic>? shader(Shader? shader) {
    if (shader == null) return null;
    // TODO: not implement
    throw UnimplementedError();
  }

  /// Extension mechanism for [shader].
  static final Map<Type, ArgumentEncoder<Shader, Map<String, dynamic>?>>
      shaderEncoders = <Type, ArgumentEncoder<Shader, Map<String, dynamic>>>{};

  /// Returns a string from the specified string.
  ///
  /// Returns the empty string if it's not a string.
  ///
  /// This is useful in situations where null is not acceptable, for example,
  /// when providing a decoder to [list]. Otherwise, prefer using [DataSource.v]
  /// directly.
  static String? string(String? value) {
    if (value == null) return null;
    return '\'$value\'';
  }

  /// Returns a [StrutStyle] from the specified map.
  ///
  /// If the map is absent, returns null.
  ///
  /// Otherwise (even if it has no keys), the [StrutStyle] is created from the
  /// following keys: 'fontFamily` (string), `fontFamilyFallback` ([list] of
  /// [string]), `fontSize` (double), `height` (double), `leadingDistribution`
  /// ([enumValue] of [TextLeadingDistribution]), `leading` (double),
  /// `fontWeight` ([enumValue] of [FontWeight]), `fontStyle` ([enumValue] of
  /// [FontStyle]), `forceStrutHeight` (boolean).
  static Map<String, dynamic>? strutStyle(StrutStyle? style) {
    if (style == null) return null;
    return NotNullMap.from({
      'fontFamily': style.fontFamily,
      'fontFamilyFallback':
          list<String, String?>(style.fontFamilyFallback, string),
      'fontSize': style.fontSize,
      'height': style.height,
      'leadingDistribution': enumValue(style.leadingDistribution),
      'leading': style.leading,
      'fontWeight': enumValue(style.fontWeight),
      'fontStyle': enumValue(style.fontStyle),
      'forceStrutHeight': style.forceStrutHeight
    });
  }

  /// Returns a [TextHeightBehavior] from the specified map.
  ///
  /// If the map is absent, returns null.
  ///
  /// Otherwise (even if it has no keys), the [TextHeightBehavior] is created
  /// from the following keys: 'applyHeightToFirstAscent` (boolean; defaults to
  /// true), `applyHeightToLastDescent` (boolean, defaults to true), and
  /// `leadingDistribution` ([enumValue] of [TextLeadingDistribution], deafults
  /// to [TextLeadingDistribution.proportional]).
  static Map<String, dynamic>? textHeightBehavior(
      TextHeightBehavior? behavior) {
    if (behavior == null) return null;
    return NotNullMap.from({
      'applyHeightToFirstAscent': behavior.applyHeightToFirstAscent,
      'applyHeightToLastDescent': behavior.applyHeightToLastDescent,
      'leadingDistribution': enumValue(behavior.leadingDistribution),
    });
  }

  /// Returns a [TextDecoration] from the specified list or string.
  ///
  /// If the key identifies a list, then each entry in the list is decoded by
  /// recursively invoking [textDecoration], and the result is the combination
  /// of those [TextDecoration] values as obtained using
  /// [TextDecoration.combine].
  ///
  /// Otherwise, if the key identifies a string, then the value `lineThrough` is
  /// mapped to [TextDecoration.lineThrough], `overline` to
  /// [TextDecoration.overline], and `underline` to [TextDecoration.underline].
  /// Other values (and the abscence of a value) are interpreted as
  /// [TextDecoration.none].
  ///
  /// @return null|String|List<String>
  static dynamic textDecoration(TextDecoration? decoration) {
    if (decoration == null) return null;

    String type = decoration.toString();
    if (type.startsWith('TextDecoration.combine')) {
      List<String> combine = type
          .substring('TextDecoration.combine('.length, type.length - 1)
          .split(', ');
      if (combine.isEmpty) return null;
      if (combine.length == 1) return [combine.first];
      return combine;
    } else {
      switch (decoration) {
        case TextDecoration.lineThrough:
          return 'lineThrough';
        case TextDecoration.overline:
          return 'overline';
        case TextDecoration.underline:
          return 'underline';
        default:
          return null;
      }
    }
  }

  /// Returns a [TextStyle] from the specified map.
  ///
  /// If the map is absent, returns null.
  ///
  /// Otherwise (even if it has no keys), the [TextStyle] is created from the
  /// following keys: `color` ([color]), `backgroundColor` ([color]), `fontSize`
  /// (double), `fontWeight` ([enumValue] of [FontWeight]), `fontStyle`
  /// ([enumValue] of [FontStyle]), `letterSpacing` (double), `wordSpacing`
  /// (double), `textBaseline` ([enumValue] of [TextBaseline]), `height`
  /// (double), `leadingDistribution` ([enumValue] of
  /// [TextLeadingDistribution]), `locale` ([locale]), `foreground` ([paint]),
  /// `background` ([paint]), `shadows` ([list] of [boxShadow]s), `fontFeatures`
  /// ([list] of [fontFeature]s), `decoration` ([textDecoration]),
  /// `decorationColor` ([color]), `decorationStyle` ([enumValue] of
  /// [TextDecorationStyle]), `decorationThickness` (double), 'fontFamily`
  /// (string), `fontFamilyFallback` ([list] of [string]), and `overflow`
  /// ([enumValue] of [TextOverflow]).
  static Map<String, dynamic>? textStyle(TextStyle? style) {
    if (style == null) return null;
    return NotNullMap.from({
      'color': color(style.color),
      'backgroundColor': color(style.backgroundColor),
      'fontSize': style.fontSize,
      'fontWeight': enumValue(style.fontWeight),
      'fontStyle': enumValue(style.fontStyle),
      'letterSpacing': style.letterSpacing,
      'wordSpacing': style.wordSpacing,
      'textBaseline': enumValue(style.textBaseline),
      'height': style.height,
      'leadingDistribution': enumValue(style.leadingDistribution),
      'locale': locale(style.locale),
      'foreground': paint(style.foreground),
      'background': paint(style.background),
      'shadows': list<Shadow, Map<String, dynamic>?>(style.shadows, boxShadow),
      'fontFeatures': list<FontFeature, Map<String, dynamic>?>(
          style.fontFeatures, fontFeature),
      'decoration': textDecoration(style.decoration),
      'decorationColor': color(style.decorationColor),
      'decorationStyle': enumValue(style.decorationStyle),
      'decorationThickness': style.decorationThickness,
      'fontFamily': style.fontFamily,
      'fontFamilyFallback':
          list<String, String?>(style.fontFamilyFallback, string),
    });
  }

  /// Returns a [VisualDensity] from the specified string or map.
  ///
  /// If the specified value is a string, then it is interpreted as follows:
  ///
  ///  * `adaptivePlatformDensity`: returns
  ///    [VisualDensity.adaptivePlatformDensity] (which varies by platform).
  ///  * `comfortable`: returns [VisualDensity.comfortable].
  ///  * `compact`: returns [VisualDensity.compact].
  ///  * `standard`: returns [VisualDensity.standard].
  ///
  /// Otherwise, if the specified value is a map, then the keys `horizontal` and
  /// `vertical` (doubles) are used to create a custom [VisualDensity]. The
  /// specified values must be in the range given by
  /// [VisualDensity.minimumDensity] to [VisualDensity.maximumDensity]. Missing
  /// values are interpreted as zero.
  static Map<String, dynamic>? visualDensity(VisualDensity? density) {
    if (density == null) return null;
    return {'horizontal': density.horizontal, 'vertical': density.vertical};
  }

  static Map<Type, WidgetVisitor> visitorMap = Map.from(coreWidgetsVisitorMap)
    ..addAll(materialVisitorMap);

  static ConstructorCall? widget(Widget? widget) {
    if (widget == null) return null;
    if (visitorMap.containsKey(widget.runtimeType)) {
      return visitorMap[widget.runtimeType]!.visit(widget);
    }
    throw 'Unsupported widget type: ${widget.runtimeType}';
  }

  static List<ConstructorCall>? widgetList(List<Widget>? widgets) {
    if (widgets == null) return null;
    Map<Type, WidgetVisitor> visitorMap = Map.from(coreWidgetsVisitorMap)
      ..addAll(materialVisitorMap);

    return widgets.map((widget) {
      if (visitorMap.containsKey(widget.runtimeType)) {
        return visitorMap[widget.runtimeType]!.visit(widget);
      }
      throw 'Unsupported widget type: ${widget.runtimeType}';
    }).toList();
  }
}
