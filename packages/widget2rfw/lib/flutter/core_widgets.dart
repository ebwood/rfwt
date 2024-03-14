import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:rfw/rfw.dart';

import 'arguments_encoder.dart';
import 'runtime.dart';

Map<Type, dynamic> coreWidgetsVisitorMap = {
  AnimatedAlign: AnimatedAlignVisitor(),
  AnimatedContainer: AnimatedContainerVisitor(),
  AnimatedDefaultTextStyle: AnimatedDefaultTextStyleVisitor(),
  AnimatedOpacity: AnimatedOpacityVisitor(),
  AnimatedPadding: AnimatedPaddingVisitor(),
  AnimatedPositioned: AnimatedPositionedVisitor(),
  AnimatedRotation: RotationVisitor(),
  AnimatedScale: ScaleVisitor(),
  AnimationDefaults: AnimationDefaultsVisitor(),
  Align: AlignVisitor(),
  AspectRatio: AspectRatioVisitor(),
  Center: CenterVisitor(),
  ClipRRect: ClipRRectVisitor(),
  ColoredBox: ColoredBoxVisitor(),
  Column: ColumnVisitor(),
  Container: ContainerVisitor(),
  DefaultTextStyle: DefaultTextStyleVisitor(),
  Directionality: DirectionalityVisitor(),
  Expanded: ExpandedVisitor(),
  FittedBox: FittedBoxVisitor(),
  FractionallySizedBox: FractionallySizedBoxVisitor(),
  GestureDetector: GestureDetectorVisitor(),
  GridView: GridViewVisitor(),
  Icon: IconVisitor(),
  IconTheme: IconThemeVisitor(),
  IntrinsicHeight: IntrinsicHeightVisitor(),
  IntrinsicWidth: IntrinsicWidthVisitor(),
  Image: ImageVisitor(),
  ListBody: ListBodyVisitor(),
  ListView: ListViewVisitor(),
  Opacity: OpacityVisitor(),
  Padding: PaddingVisitor(),
  Placeholder: PlaceholderVisitor(),
  Positioned: PositionedVisitor(),
  Row: RowVisitor(),
  SafeArea: SafeAreaVisitor(),
  SingleChildScrollView: SingleChildScrollViewVisitor(),
  SizedBox: SizedBoxVisitor(),
  Spacer: SpacerVisitor(),
  Stack: StackVisitor(),
  Text: TextVisitor(),
  Wrap: WrapVisitor(),
};

sealed class CoreWidgetVisitor extends WidgetVisitor {
  @override
  ConstructorCall visit(covariant Widget widget);
}

class AnimatedAlignVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(AnimatedAlign widget) {
    Map<String, dynamic> props = NotNullMap.from({
      'duration': ArgumentEncoders.duration(widget.duration),
      'curve': ArgumentEncoders.curve(widget.curve),
      'alignment': ArgumentEncoders.alignment(widget.alignment),
      'widthFactor': widget.widthFactor,
      'heightFactor': widget.heightFactor,
      'child': ArgumentEncoders.widget(widget.child),
    });
    return ConstructorCall('Align', props);
  }
}

class AnimatedContainerVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(AnimatedContainer widget) {
    Map<String, dynamic>? constraints =
        ArgumentEncoders.boxConstraints(widget.constraints);

    NotNullMap<String, dynamic> props = NotNullMap.from({
      'duration': ArgumentEncoders.duration(widget.duration),
      'curve': ArgumentEncoders.curve(widget.curve),
      'alignment': ArgumentEncoders.alignment(widget.alignment),
      'padding': ArgumentEncoders.edgeInsets(widget.padding),
      // TODO: if decoration is null, color will be added to new generated decoration, cannot get color from AnimatedContainer, need to be fixed. It's the other reason to use code_builder get props
      // writeIfNotNull(widget.color, (value) { })
      // 'color': ;
      'decoration': ArgumentEncoders.decoration(widget.decoration),
      'foregroundDecoration':
          ArgumentEncoders.decoration(widget.foregroundDecoration),
      'width': constraints?['width'],
      'height': constraints?['height'],
      'constraints': ArgumentEncoders.boxConstraints(widget.constraints),
      'margin': ArgumentEncoders.edgeInsets(widget.margin),
      'transform': ArgumentEncoders.matrix(widget.transform),
      'transformAlignment':
          ArgumentEncoders.alignment(widget.transformAlignment),
      'clipBehavior': ArgumentEncoders.enumValue<Clip>(widget.clipBehavior),
      'onEnd': DataSourceEncoder.voidHandler(widget.onEnd),
      'child': ArgumentEncoders.widget(widget.child),
    });

    return ConstructorCall('Container', props);
  }
}

class AnimatedDefaultTextStyleVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(covariant AnimatedDefaultTextStyle widget) {
    return ConstructorCall(
        'DefaultTextStyle',
        NotNullMap.from({
          'duration': ArgumentEncoders.duration(widget.duration),
          'curve': ArgumentEncoders.curve(widget.curve),
          'style': ArgumentEncoders.textStyle(widget.style),
          'textAlign': ArgumentEncoders.enumValue<TextAlign>(widget.textAlign),
          'softWrap': widget.softWrap,
          'overflow': ArgumentEncoders.enumValue<TextOverflow>(widget.overflow),
          'maxLines': widget.maxLines,
          'textWidthBasis':
              ArgumentEncoders.enumValue<TextWidthBasis>(widget.textWidthBasis),
          'textHeightBehavior':
              ArgumentEncoders.textHeightBehavior(widget.textHeightBehavior),
          'onEnd': DataSourceEncoder.voidHandler(widget.onEnd),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class AnimatedOpacityVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(AnimatedOpacity widget) {
    return ConstructorCall(
        'Opacity',
        NotNullMap.from({
          'duration': ArgumentEncoders.duration(widget.duration),
          'curve': ArgumentEncoders.curve(widget.curve),
          'onEnd': DataSourceEncoder.voidHandler(widget.onEnd),
          'opacity': widget.opacity,
          'alwaysIncludeSemantics': widget.alwaysIncludeSemantics,
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class AnimatedPaddingVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(AnimatedPadding widget) {
    return ConstructorCall(
        'Padding',
        NotNullMap.from({
          'duration': ArgumentEncoders.duration(widget.duration),
          'curve': ArgumentEncoders.curve(widget.curve),
          'padding': ArgumentEncoders.edgeInsets(widget.padding),
          'onEnd': DataSourceEncoder.voidHandler(widget.onEnd),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class AnimatedPositionedVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(AnimatedPositioned widget) {
    return ConstructorCall(
        'Positioned',
        NotNullMap.from({
          'duration': ArgumentEncoders.duration(widget.duration),
          'curve': ArgumentEncoders.curve(widget.curve),
          'start': widget.left,
          'top': widget.top,
          'end': widget.right,
          'bottom': widget.bottom,
          'width': widget.width,
          'height': widget.height,
          'onEnd': DataSourceEncoder.voidHandler(widget.onEnd),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class AnimationDefaultsVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(AnimationDefaults widget) {
    Map<String, dynamic> props = NotNullMap.from({
      'duration': ArgumentEncoders.duration(widget.duration),
      'curve': ArgumentEncoders.curve(widget.curve),
      'child': ArgumentEncoders.widget(widget),
    });

    return ConstructorCall('${widget.runtimeType}', props);
  }
}

class AlignVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Align widget) {
    Map<String, dynamic> props = NotNullMap.from({
      'alignment': ArgumentEncoders.alignment(widget.alignment),
      'widthFactor': widget.widthFactor,
      'heightFactor': widget.heightFactor,
      'child': ArgumentEncoders.widget(widget.child),
    });
    return ConstructorCall('Align', props);
  }
}

class AspectRatioVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(AspectRatio widget) {
    return ConstructorCall(
      'AspectRatio',
      NotNullMap.from({
        'aspectRatio': widget.aspectRatio,
        'child': ArgumentEncoders.widget(widget.child),
      }),
    );
  }
}

class CenterVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Center widget) {
    return ConstructorCall(
      'Center',
      NotNullMap.from({
        'widthFactor': widget.widthFactor,
        'heightFactor': widget.heightFactor,
        'child': ArgumentEncoders.widget(widget.child),
      }),
    );
  }
}

class ClipRRectVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(ClipRRect widget) {
    return ConstructorCall(
      'ClipRRect',
      NotNullMap.from({
        'borderRadius': ArgumentEncoders.borderRadius(widget.borderRadius),
        'clipBehavior': ArgumentEncoders.enumValue<Clip>(widget.clipBehavior),
        'child': ArgumentEncoders.widget(widget.child),
      }),
    );
  }
}

class ColoredBoxVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(ColoredBox widget) {
    return ConstructorCall(
      'ColoredBox',
      NotNullMap.from({
        'color': ArgumentEncoders.color(widget.color),
        'child': ArgumentEncoders.widget(widget.child),
      }),
    );
  }
}

class ColumnVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Column widget) {
    return ConstructorCall(
      'Column',
      NotNullMap.from({
        'mainAxisAlignment': ArgumentEncoders.enumValue<MainAxisAlignment>(
            widget.mainAxisAlignment),
        'mainAxisSize':
            ArgumentEncoders.enumValue<MainAxisSize>(widget.mainAxisSize),
        'crossAxisAlignment': ArgumentEncoders.enumValue<CrossAxisAlignment>(
            widget.crossAxisAlignment),
        'textDirection':
            ArgumentEncoders.enumValue<TextDirection>(widget.textDirection),
        'verticalDirection': ArgumentEncoders.enumValue<VerticalDirection>(
            widget.verticalDirection),
        'textBaseline':
            ArgumentEncoders.enumValue<TextBaseline>(widget.textBaseline),
        'children': ArgumentEncoders.widgetList(widget.children),
      }),
    );
  }
}

class ContainerVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Container widget) {
    // TODO: the value is already set to constraints, this another reason to get width/height from code generator tool
    Map<String, dynamic>? constraints =
        ArgumentEncoders.boxConstraints(widget.constraints);

    return ConstructorCall(
        'Container',
        NotNullMap.from({
          'alignment': ArgumentEncoders.alignment(widget.alignment),
          'padding': ArgumentEncoders.edgeInsets(widget.padding),
          'color': ArgumentEncoders.color(widget.color),
          'decoration': ArgumentEncoders.decoration(widget.decoration),
          'foregroundDecoration':
              ArgumentEncoders.decoration(widget.foregroundDecoration),
          'width': constraints?['minWidth'],
          'height': constraints?['minHeight'],
          'constraints': constraints,
          'margin': ArgumentEncoders.edgeInsets(widget.margin),
          'transform': ArgumentEncoders.matrix(widget.transform),
          'transformAlignment':
              ArgumentEncoders.alignment(widget.transformAlignment),
          'clipBehavior': ArgumentEncoders.enumValue<Clip>(widget.clipBehavior),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class DefaultTextStyleVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(DefaultTextStyle widget) {
    return ConstructorCall(
        'DefaultTextStyle',
        NotNullMap.from({
          'style': ArgumentEncoders.textStyle(widget.style),
          'textAlign': ArgumentEncoders.enumValue<TextAlign>(widget.textAlign),
          'softWrap': widget.softWrap,
          'overflow': ArgumentEncoders.enumValue<TextOverflow>(widget.overflow),
          'maxLines': widget.maxLines,
          'textWidthBasis':
              ArgumentEncoders.enumValue<TextWidthBasis>(widget.textWidthBasis),
          'textHeightBehavior':
              ArgumentEncoders.textHeightBehavior(widget.textHeightBehavior),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class DirectionalityVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Directionality widget) {
    return ConstructorCall(
        'Directionality',
        NotNullMap.from({
          'textDirection':
              ArgumentEncoders.enumValue<TextDirection>(widget.textDirection),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class ExpandedVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Expanded widget) {
    return ConstructorCall(
        'Expanded',
        NotNullMap.from({
          'flex': widget.flex,
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class FittedBoxVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(FittedBox widget) {
    return ConstructorCall(
        'FittedBox',
        NotNullMap.from({
          'fit': ArgumentEncoders.enumValue<BoxFit>(widget.fit),
          'alignment': ArgumentEncoders.alignment(widget.alignment),
          'clipBehavior': ArgumentEncoders.enumValue<Clip>(widget.clipBehavior),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class FractionallySizedBoxVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(FractionallySizedBox widget) {
    return ConstructorCall(
        'FractionallySizedBox',
        NotNullMap.from({
          'widthFactor': widget.widthFactor,
          'heightFactor': widget.heightFactor,
          'alignment': ArgumentEncoders.alignment(widget.alignment),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

/// TODO: EventHandler not implemented right
class GestureDetectorVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(GestureDetector widget) {
    return ConstructorCall(
        'GestureDetector',
        NotNullMap.from({
          'onTap': DataSourceEncoder.voidHandler(widget.onTap),
          'onTapDown': DataSourceEncoder.handler(widget.onTapDown),
          'onTapUp': DataSourceEncoder.handler(widget.onTapUp),
          'onTapCancel': DataSourceEncoder.voidHandler(widget.onTapCancel),
          'onDoubleTap': DataSourceEncoder.voidHandler(widget.onDoubleTap),
          'onLongPress': DataSourceEncoder.voidHandler(widget.onLongPress),
          'behavior':
              ArgumentEncoders.enumValue<HitTestBehavior>(widget.behavior),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

// TODO: not implemented
class GridViewVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(GridView widget) {
    SliverChildDelegate delegate = widget.childrenDelegate;
    Map<String, dynamic> props = {};
    if (delegate is SliverChildListDelegate) {
      props = NotNullMap.from({
        'children': ArgumentEncoders.widgetList(delegate.children),
        'addAutomaticKeepAlives': delegate.addAutomaticKeepAlives,
        'addRepaintBoundaries': delegate.addRepaintBoundaries,
        'addSemanticIndexes': delegate.addSemanticIndexes,
      });
    } else if (delegate is SliverChildBuilderDelegate) {
      props = NotNullMap.from({
        // 'children': ArgumentEncoders.widgetList(delegate.builder),
        'addAutomaticKeepAlives': delegate.addAutomaticKeepAlives,
        'addRepaintBoundaries': delegate.addRepaintBoundaries,
        'addSemanticIndexes': delegate.addSemanticIndexes,
      });
    }

    return ConstructorCall(
      'GridView',
      NotNullMap.from({
        ...props,
        'scrollDirection':
            ArgumentEncoders.enumValue<Axis>(widget.scrollDirection),
        'reverse': widget.reverse,
        'primary': widget.primary,
        'shrinkWrap': widget.shrinkWrap,
        'padding': ArgumentEncoders.edgeInsets(widget.padding),
        'gridDelegate': ArgumentEncoders.gridDelegate(widget.gridDelegate),
        'cacheExtent': widget.cacheExtent,
        'semanticChildCount': widget.semanticChildCount,
        'dragStartBehavior': ArgumentEncoders.enumValue<DragStartBehavior>(
            widget.dragStartBehavior),
        'keyboardDismissBehavior':
            ArgumentEncoders.enumValue<ScrollViewKeyboardDismissBehavior>(
                widget.keyboardDismissBehavior),
        'restorationId': ArgumentEncoders.string(widget.restorationId),
        'clipBehavior': ArgumentEncoders.enumValue<Clip>(widget.clipBehavior),
      }),
    );
  }
}

class IconVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Icon widget) {
    return ConstructorCall(
        'Icon',
        NotNullMap.from({
          ...?ArgumentEncoders.iconData(widget.icon),
          'size': widget.size,
          'color': widget.color,
          'semanticLabel': ArgumentEncoders.string(widget.semanticLabel),
          'textDirection':
              ArgumentEncoders.enumValue<TextDirection>(widget.textDirection),
        }));
  }
}

class IconThemeVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(IconTheme widget) {
    return ConstructorCall(
        'IconTheme',
        NotNullMap.from({
          ...?ArgumentEncoders.iconThemeData(widget.data),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class IntrinsicHeightVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(IntrinsicHeight widget) {
    return ConstructorCall(
      'IntrinsicHeight',
      NotNullMap.from({
        'child': ArgumentEncoders.widget(widget.child),
      }),
    );
  }
}

class IntrinsicWidthVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(IntrinsicWidth widget) {
    return ConstructorCall(
      'IntrinsicWidth',
      NotNullMap.from({
        'child': ArgumentEncoders.widget(widget.child),
      }),
    );
  }
}

class ImageVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Image widget) {
    return ConstructorCall(
      'Image',
      NotNullMap.from({
        ...?ArgumentEncoders.imageProvider(widget.image),
        'semanticLabel': ArgumentEncoders.string(widget.semanticLabel),
        'excludeFromSemantics': widget.excludeFromSemantics,
        'width': widget.width,
        'height': widget.height,
        'color': ArgumentEncoders.color(widget.color),
        'blendMode':
            ArgumentEncoders.enumValue<BlendMode>(widget.colorBlendMode),
        'fit': ArgumentEncoders.enumValue<BoxFit>(widget.fit),
        'alignment': ArgumentEncoders.alignment(widget.alignment),
        'repeat': ArgumentEncoders.enumValue<ImageRepeat>(widget.repeat),
        'centerSlice': ArgumentEncoders.rect(widget.centerSlice),
        'matchTextDirection': widget.matchTextDirection,
        'gaplessPlayback': widget.gaplessPlayback,
        'isAntiAlias': widget.isAntiAlias,
        'filterQuality':
            ArgumentEncoders.enumValue<FilterQuality>(widget.filterQuality),
      }),
    );
  }
}

class ListBodyVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(ListBody widget) {
    return ConstructorCall(
        'ListBody',
        NotNullMap.from({
          'mainAxis': ArgumentEncoders.enumValue<Axis>(widget.mainAxis),
          'reverse': widget.reverse,
          'children': ArgumentEncoders.widgetList(widget.children),
        }));
  }
}

class ListViewVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(ListView widget) {
    SliverChildDelegate delegate = widget.childrenDelegate;
    Map<String, dynamic> props = NotNullMap();
    if (delegate is SliverChildListDelegate) {
      props = NotNullMap.from({
        'children': ArgumentEncoders.widgetList(delegate.children),
        'addAutomaticKeepAlives': delegate.addAutomaticKeepAlives,
        'addRepaintBoundaries': delegate.addRepaintBoundaries,
        'addSemanticIndexes': delegate.addSemanticIndexes,
      });
    } else if (delegate is SliverChildBuilderDelegate) {
      props = NotNullMap.from({
        // TODO: not implemented
        // 'children': delegate.
        'addAutomaticKeepAlives': delegate.addAutomaticKeepAlives,
        'addRepaintBoundaries': delegate.addRepaintBoundaries,
        'addSemanticIndexes': delegate.addSemanticIndexes,
      });
    }
    return ConstructorCall(
        'ListView',
        NotNullMap.from({
          ...props,
          'scrollDirection':
              ArgumentEncoders.enumValue<Axis>(widget.scrollDirection),
          'reverse': widget.reverse,
          'primary': widget.primary,
          'shrinkWrap': widget.shrinkWrap,
          'padding': ArgumentEncoders.edgeInsets(widget.padding),
          'itemExtent': widget.itemExtent,
          'prototypeItem': ArgumentEncoders.widget(widget.prototypeItem),
          'clipBehavior': ArgumentEncoders.enumValue<Clip>(widget.clipBehavior),
          'cacheExtent': widget.cacheExtent,
          'semanticChildCount': widget.semanticChildCount,
          'dragStartBehavior': ArgumentEncoders.enumValue<DragStartBehavior>(
              widget.dragStartBehavior),
          'keyboardDismissBehavior':
              ArgumentEncoders.enumValue<ScrollViewKeyboardDismissBehavior>(
                  widget.keyboardDismissBehavior),
          'restorationId': ArgumentEncoders.string(widget.restorationId),
        }));
  }
}

class OpacityVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Opacity widget) {
    return ConstructorCall(
        'Opacity',
        NotNullMap.from({
          'opacity': widget.opacity,
          'alwaysIncludeSemantics': widget.alwaysIncludeSemantics,
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class PaddingVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Padding widget) {
    return ConstructorCall(
        'Padding',
        NotNullMap.from({
          'padding': ArgumentEncoders.edgeInsets(widget.padding),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class PlaceholderVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Placeholder widget) {
    return ConstructorCall(
        'Placeholder',
        NotNullMap.from({
          'color': ArgumentEncoders.color(widget.color),
          'strokeWidth': widget.strokeWidth,
          'fallbackWidth': widget.fallbackWidth,
          'fallbackHeight': widget.fallbackHeight,
        }));
  }
}

class PositionedVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Positioned widget) {
    return ConstructorCall(
        'Positioned',
        NotNullMap.from({
          'start': widget.left,
          'top': widget.top,
          'end': widget.right,
          'bottom': widget.bottom,
          'width': widget.width,
          'height': widget.height,
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class RotationVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(AnimatedRotation widget) {
    return ConstructorCall(
        'Rotation',
        NotNullMap.from({
          'duration': ArgumentEncoders.duration(widget.duration),
          'curve': ArgumentEncoders.curve(widget.curve),
          'turns': widget.turns,
          'alignment': ArgumentEncoders.alignment(widget.alignment),
          'filterQuality':
              ArgumentEncoders.enumValue<FilterQuality>(widget.filterQuality),
          'child': ArgumentEncoders.widget(widget.child),
          'onEnd': widget.onEnd
        }));
  }
}

class RowVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Row widget) {
    return ConstructorCall(
        'Row',
        NotNullMap.from({
          'mainAxisAlignment': ArgumentEncoders.enumValue<MainAxisAlignment>(
              widget.mainAxisAlignment),
          'mainAxisSize':
              ArgumentEncoders.enumValue<MainAxisSize>(widget.mainAxisSize),
          'crossAxisAlignment': ArgumentEncoders.enumValue<CrossAxisAlignment>(
              widget.crossAxisAlignment),
          'textDirection':
              ArgumentEncoders.enumValue<TextDirection>(widget.textDirection),
          'verticalDirection': ArgumentEncoders.enumValue<VerticalDirection>(
              widget.verticalDirection),
          'textBaseline':
              ArgumentEncoders.enumValue<TextBaseline>(widget.textBaseline),
          'children': ArgumentEncoders.widgetList(widget.children),
        }));
  }
}

class SafeAreaVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(SafeArea widget) {
    return ConstructorCall(
        'SafeArea',
        NotNullMap.from({
          'left': widget.left,
          'top': widget.top,
          'right': widget.right,
          'bottom': widget.bottom,
          'minimum': ArgumentEncoders.edgeInsets(widget.minimum),
          'maintainBottomViewPadding': widget.maintainBottomViewPadding,
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class ScaleVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(AnimatedScale widget) {
    return ConstructorCall(
        'Scale',
        NotNullMap.from({
          'duration': ArgumentEncoders.duration(widget.duration),
          'curve': ArgumentEncoders.curve(widget.curve),
          'scale': widget.scale,
          'alignment': ArgumentEncoders.alignment(widget.alignment),
          'filterQuality':
              ArgumentEncoders.enumValue<FilterQuality>(widget.filterQuality),
          'child': ArgumentEncoders.widget(widget.child),
          'onEnd': widget.onEnd
        }));
  }
}

class SingleChildScrollViewVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(SingleChildScrollView widget) {
    return ConstructorCall(
        'SingleChildScrollView',
        NotNullMap.from({
          'scrollDirection':
              ArgumentEncoders.enumValue<Axis>(widget.scrollDirection),
          'reverse': widget.reverse,
          'padding': ArgumentEncoders.edgeInsets(widget.padding),
          'primary': widget.primary,
          'dragStartBehavior': ArgumentEncoders.enumValue<DragStartBehavior>(
              widget.dragStartBehavior),
          'clipBehavior': ArgumentEncoders.enumValue<Clip>(widget.clipBehavior),
          'restorationId': ArgumentEncoders.string(widget.restorationId),
          'keyboardDismissBehavior':
              ArgumentEncoders.enumValue<ScrollViewKeyboardDismissBehavior>(
                  widget.keyboardDismissBehavior),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class SizedBoxVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(SizedBox widget) {
    if (widget.width == double.infinity && widget.width == double.infinity) {
      return ConstructorCall('SizedBoxExpand',
          NotNullMap.from({'child': ArgumentEncoders.widget(widget.child)}));
    }
    if (widget.width == 0 && widget.height == 0) {
      return ConstructorCall('SizedBoxShrink',
          NotNullMap.from({'child': ArgumentEncoders.widget(widget.child)}));
    }

    return ConstructorCall(
        'SizedBox',
        NotNullMap.from({
          'width': widget.width,
          'height': widget.height,
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class SpacerVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Spacer widget) {
    return ConstructorCall('Spacer', {'flex': widget.flex});
  }
}

class StackVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Stack widget) {
    return ConstructorCall(
        'Stack',
        NotNullMap.from({
          'alignment': ArgumentEncoders.alignment(widget.alignment),
          'textDirection':
              ArgumentEncoders.enumValue<TextDirection>(widget.textDirection),
          'fit': ArgumentEncoders.enumValue<StackFit>(widget.fit),
          'clipBehavior': ArgumentEncoders.enumValue<Clip>(widget.clipBehavior),
          'children': ArgumentEncoders.widgetList(widget.children),
        }));
  }
}

class TextVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Text widget) {
    double? fontSize = widget.style?.fontSize;
    return ConstructorCall(
        'Text',
        NotNullMap.from({
          'text': ArgumentEncoders.string(widget.data),
          'style': ArgumentEncoders.textStyle(widget.style),
          'strutStyle': ArgumentEncoders.strutStyle(widget.strutStyle),
          'textAlign': ArgumentEncoders.enumValue<TextAlign>(widget.textAlign),
          'textDirection':
              ArgumentEncoders.enumValue<TextDirection>(widget.textDirection),
          'locale': ArgumentEncoders.locale(widget.locale),
          'softWrap': widget.softWrap,
          'overflow': ArgumentEncoders.enumValue<TextOverflow>(widget.overflow),
          // TODO: not verified yet
          'textScaleFactor': widget.textScaler == TextScaler.noScaling
              ? null
              : fontSize != null
                  ? widget.textScaler?.scale(fontSize)
                  : null,
          'maxLines': widget.maxLines,
          'semanticsLabel': ArgumentEncoders.string(widget.semanticsLabel),
          'textWidthBasis':
              ArgumentEncoders.enumValue<TextWidthBasis>(widget.textWidthBasis),
          'textHeightBehavior':
              ArgumentEncoders.textHeightBehavior(widget.textHeightBehavior),
        }));
  }
}

class WrapVisitor implements CoreWidgetVisitor {
  @override
  ConstructorCall visit(Wrap widget) {
    return ConstructorCall(
        'Wrap',
        NotNullMap.from({
          'direction': ArgumentEncoders.enumValue<Axis>(widget.direction),
          'alignment':
              ArgumentEncoders.enumValue<WrapAlignment>(widget.alignment),
          'spacing': widget.spacing,
          'runAlignment':
              ArgumentEncoders.enumValue<WrapAlignment>(widget.runAlignment),
          'runSpacing': widget.runSpacing,
          'crossAxisAlignment': ArgumentEncoders.enumValue<WrapCrossAlignment>(
              widget.crossAxisAlignment),
          'textDirection':
              ArgumentEncoders.enumValue<TextDirection>(widget.textDirection),
          'verticalDirection': ArgumentEncoders.enumValue<VerticalDirection>(
              widget.verticalDirection),
          'clipBehavior': ArgumentEncoders.enumValue<Clip>(widget.clipBehavior),
          'children': ArgumentEncoders.widgetList(widget.children),
        }));
  }
}
