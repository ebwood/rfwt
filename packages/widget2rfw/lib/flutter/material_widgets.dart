import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:rfw/rfw.dart';

import 'arguments_encoder.dart';
import 'runtime.dart';

Map<Type, MaterialWidgetVisitor> materialVisitorMap = {
  AboutListTile: AboutListTileVisitor(),
  AppBar: AppBarVisitor(),
  ButtonBar: ButtonBarVisitor(),
  OverflowBar: OverflowBarVisitor(),
  Card: CardVisitor(),
  CircularProgressIndicator: CircularProgressIndicatorVisitor(),
  Divider: DividerVisitor(),
  Drawer: DrawerVisitor(),
  DrawerHeader: DrawerHeaderVisitor(),
  DropdownButton: DropdownButtonVisitor(),
  ElevatedButton: ElevatedButtonVisitor(),
  FloatingActionButton: FloatingActionButtonVisitor(),
  InkResponse: InkResponseVisitor(),
  InkWell: InkWellVisitor(),
  LinearProgressIndicator: LinearProgressIndicatorVisitor(),
  ListTile: ListTileVisitor(),
  Material: MaterialVisitor(),
  OutlinedButton: OutlinedButtonVisitor(),
  Scaffold: ScaffoldVisitor(),
  TextButton: TextButtonVisitor(),
  VerticalDivider: VerticalDividerVisitor(),
};

sealed class MaterialWidgetVisitor extends WidgetVisitor {
  @override
  ConstructorCall visit(covariant Widget widget);
}

class AboutListTileVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(AboutListTile widget) {
    return ConstructorCall(
        'AboutListTile',
        NotNullMap.from({
          'icon': ArgumentEncoders.widget(widget.icon),
          'applicationName': ArgumentEncoders.string(widget.applicationName),
          'applicationVersion':
              ArgumentEncoders.string(widget.applicationVersion),
          'applicationIcon': ArgumentEncoders.widget(widget.applicationIcon),
          'applicationLegalese':
              ArgumentEncoders.string(widget.applicationLegalese),
          'aboutBoxChildren':
              ArgumentEncoders.widgetList(widget.aboutBoxChildren),
          'dense': widget.dense,
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class AppBarVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(AppBar widget) {
    return ConstructorCall(
        'AppBar',
        NotNullMap.from({
          'leading': ArgumentEncoders.widget(widget.leading),
          'automaticallyImplyLeading': widget.automaticallyImplyLeading,
          'actions': ArgumentEncoders.widgetList(widget.actions),
          'shadowColor': ArgumentEncoders.color(widget.shadowColor),
          'shape': ArgumentEncoders.shapeBorder(widget.shape),
          'backgroundColor': ArgumentEncoders.color(widget.backgroundColor),
          'foregroundColor': ArgumentEncoders.color(widget.foregroundColor),
          'iconTheme': ArgumentEncoders.iconThemeData(widget.iconTheme),
          'actionsIconTheme':
              ArgumentEncoders.iconThemeData(widget.actionsIconTheme),
          'primary': widget.primary,
          'centerTitle': widget.centerTitle,
          'excludeHeaderSemantics': widget.excludeHeaderSemantics,
          'titleSpacing': widget.titleSpacing,
          'toolbarOpacity': widget.toolbarOpacity,
          'toolbarHeight': widget.toolbarHeight,
          'leadingWidth': widget.leadingWidth,
          'toolbarTextStyle':
              ArgumentEncoders.textStyle(widget.toolbarTextStyle),
          'titleTextStyle': ArgumentEncoders.textStyle(widget.titleTextStyle),
        }));
  }
}

class ButtonBarVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(ButtonBar widget) {
    return ConstructorCall(
        'ButtonBar',
        NotNullMap.from({
          'buttonPadding': ArgumentEncoders.edgeInsets(widget.buttonPadding),
          'layoutBehavior': widget.layoutBehavior,
          'alignment': ArgumentEncoders.enumValue(widget.alignment),
          // TODO: not implemented
          // 'spacing': widget.
          'overflowDirection':
              ArgumentEncoders.enumValue(widget.overflowDirection),
          'overflowButtonSpacing': widget.overflowButtonSpacing,
          'children': ArgumentEncoders.widgetList(widget.children),
        }));
  }
}

class OverflowBarVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(OverflowBar widget) {
    return ConstructorCall(
        'OverflowBar',
        NotNullMap.from({
          'alignment': ArgumentEncoders.enumValue(widget.alignment),
          'spacing': widget.spacing,
          'overflowDirection':
              ArgumentEncoders.enumValue(widget.overflowDirection),
          'overflowSpacing': widget.overflowSpacing,
          'children': ArgumentEncoders.widgetList(widget.children),
        }));
  }
}

class CardVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(Card widget) {
    return ConstructorCall(
        'Card',
        NotNullMap.from({
          'color': ArgumentEncoders.color(widget.color),
          'shadowColor': ArgumentEncoders.color(widget.shadowColor),
          'elevation': widget.elevation,
          'margin': ArgumentEncoders.edgeInsets(widget.margin),
          'shape': ArgumentEncoders.shapeBorder(widget.shape),
          'borderOnForeground': widget.borderOnForeground,
          'clipBehavior': ArgumentEncoders.enumValue(widget.clipBehavior),
          'semanticContainer': widget.semanticContainer,
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class CircularProgressIndicatorVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(CircularProgressIndicator widget) {
    return ConstructorCall(
        'CircularProgressIndicator',
        NotNullMap.from({
          'value': widget.value,
          'color': ArgumentEncoders.color(widget.color),
          'backgroundColor': ArgumentEncoders.color(widget.backgroundColor),
          'strokeWidth': widget.strokeWidth,
          'semanticsLabel': ArgumentEncoders.string(widget.semanticsLabel),
          'semanticsValue': ArgumentEncoders.string(widget.semanticsValue),
        }));
  }
}

class DividerVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(Divider widget) {
    return ConstructorCall(
        'Divider',
        NotNullMap.from({
          'height': widget.height,
          'thickness': widget.thickness,
          'indent': widget.indent,
          'endIndent': widget.endIndent,
          'color': ArgumentEncoders.color(widget.color),
        }));
  }
}

class DrawerVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(Drawer widget) {
    return ConstructorCall(
        'Drawer',
        NotNullMap.from({
          'elevation': widget.elevation,
          'semanticLabel': ArgumentEncoders.string(widget.semanticLabel),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class DrawerHeaderVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(DrawerHeader widget) {
    return ConstructorCall(
        'DrawerHeader',
        NotNullMap.from({
          'duration': ArgumentEncoders.duration(widget.duration),
          'curve': ArgumentEncoders.curve(widget.curve),
          'decoration': ArgumentEncoders.decoration(widget.decoration),
          'margin': ArgumentEncoders.edgeInsets(widget.margin),
          'padding': ArgumentEncoders.edgeInsets(widget.padding),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class DropdownButtonVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(DropdownButton widget) {
    List<NotNullMap>? items = widget.items?.mapIndexed((index, item) {
      return NotNullMap.from({
        'onTap': DataSourceEncoder.voidHandler(item.onTap),
        'value': item.value,
        'enabled': item.enabled,
        'alignment': ArgumentEncoders.enumValue(item.alignment),
        'child': ArgumentEncoders.widget(item.child),
      });
    }).toList();
    return ConstructorCall(
        'DropdownButton',
        NotNullMap.from({
          'items': items,
          'value': widget.value,
          'disabledHint': ArgumentEncoders.widget(widget.disabledHint),
          'onChanged': DataSourceEncoder.handler(widget.onChanged),
          'onTap': DataSourceEncoder.voidHandler(widget.onTap),
          'elevation': widget.elevation,
          'style': ArgumentEncoders.textStyle(widget.style),
          'underline': ArgumentEncoders.widget(widget.underline),
          'icon': ArgumentEncoders.widget(widget.icon),
          'iconDisabledColor': ArgumentEncoders.color(widget.iconDisabledColor),
          'iconEnabledColor': ArgumentEncoders.color(widget.iconEnabledColor),
          'iconSize': widget.iconSize,
          'isDense': widget.isDense,
          'isExpanded': widget.isExpanded,
          'itemHeight': widget.itemHeight,
          'focusColor': ArgumentEncoders.color(widget.focusColor),
          'autofocus': widget.autofocus,
          'dropdownColor': ArgumentEncoders.color(widget.dropdownColor),
          'menuMaxHeight': widget.menuMaxHeight,
          'enableFeedback': widget.enableFeedback,
          'alignment': ArgumentEncoders.enumValue(widget.alignment),
          'borderRadius': ArgumentEncoders.borderRadius(widget.borderRadius),
          'padding': ArgumentEncoders.edgeInsets(widget.padding),
        }));
  }
}

class ElevatedButtonVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(ElevatedButton widget) {
    return ConstructorCall(
      'ElevatedButton',
      NotNullMap.from({
        'onPressed': DataSourceEncoder.voidHandler(widget.onPressed),
        'onLongPress': DataSourceEncoder.voidHandler(widget.onLongPress),
        'autofocus': widget.autofocus,
        'clipBehavior': ArgumentEncoders.enumValue(widget.clipBehavior),
        'child': ArgumentEncoders.widget(widget.child),
      }),
    );
  }
}

class FloatingActionButtonVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(FloatingActionButton widget) {
    return ConstructorCall(
      'FloatingActionButton',
      NotNullMap.from({
        'tooltip': ArgumentEncoders.string(widget.tooltip),
        'foregroundColor': ArgumentEncoders.color(widget.foregroundColor),
        'backgroundColor': ArgumentEncoders.color(widget.backgroundColor),
        'focusColor': ArgumentEncoders.color(widget.focusColor),
        'hoverColor': ArgumentEncoders.color(widget.hoverColor),
        'splashColor': ArgumentEncoders.color(widget.splashColor),
        'heroTag': ArgumentEncoders.string(widget.heroTag?.toString()),
        'elevation': widget.elevation,
        'focusElevation': widget.focusElevation,
        'hoverElevation': widget.hoverElevation,
        'highlightElevation': widget.highlightElevation,
        'disabledElevation': widget.disabledElevation,
        'onPressed': DataSourceEncoder.voidHandler(widget.onPressed),
        'mini': widget.mini,
        'shape': ArgumentEncoders.shapeBorder(widget.shape),
        'clipBehavior': ArgumentEncoders.enumValue(widget.clipBehavior),
        'autofocus': widget.autofocus,
        'materialTapTargetSize':
            ArgumentEncoders.enumValue(widget.materialTapTargetSize),
        'isExtended': widget.isExtended,
        'enableFeedback': widget.enableFeedback,
        'child': ArgumentEncoders.widget(widget.child),
      }),
    );
  }
}

class InkResponseVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(InkResponse widget) {
    return ConstructorCall(
        'InkResponse',
        NotNullMap.from({
          'onTap': DataSourceEncoder.voidHandler(widget.onTap),
          'onTapDown': DataSourceEncoder.handler(widget.onTapDown),
          'onTapUp': DataSourceEncoder.handler(widget.onTapUp),
          'onTapCancel': DataSourceEncoder.voidHandler(widget.onTapCancel),
          'onDoubleTap': DataSourceEncoder.voidHandler(widget.onDoubleTap),
          'onLongPress': DataSourceEncoder.voidHandler(widget.onLongPress),
          'onSecondaryTap':
              DataSourceEncoder.voidHandler(widget.onSecondaryTap),
          'onSecondaryTapUp':
              DataSourceEncoder.handler(widget.onSecondaryTapUp),
          'onSecondaryTapDown':
              DataSourceEncoder.handler(widget.onSecondaryTapDown),
          'onSecondaryTapCancel':
              DataSourceEncoder.voidHandler(widget.onSecondaryTapCancel),
          'onHighlightChanged':
              DataSourceEncoder.handler(widget.onHighlightChanged),
          'onHover': DataSourceEncoder.handler(widget.onHover),
          'containedInkWell': widget.containedInkWell,
          'highlightShape': ArgumentEncoders.enumValue(widget.highlightShape),
          'radius': widget.radius,
          'borderRadius': ArgumentEncoders.borderRadius(widget.borderRadius),
          'customBorder': ArgumentEncoders.shapeBorder(widget.customBorder),
          'focusColor': ArgumentEncoders.color(widget.focusColor),
          'hoverColor': ArgumentEncoders.color(widget.hoverColor),
          'highlightColor': ArgumentEncoders.color(widget.highlightColor),
          'splashColor': ArgumentEncoders.color(widget.splashColor),
          'enableFeedback': widget.enableFeedback,
          'excludeFromSemantics': widget.excludeFromSemantics,
          'canRequestFocus': widget.canRequestFocus,
          'onFocusChange': DataSourceEncoder.handler(widget.onFocusChange),
          'autofocus': widget.autofocus,
          'hoverDuration': ArgumentEncoders.duration(widget.hoverDuration),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class InkWellVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(InkWell widget) {
    return ConstructorCall(
        'InkWell',
        NotNullMap.from({
          'onTap': DataSourceEncoder.voidHandler(widget.onTap),
          'onDoubleTap': DataSourceEncoder.voidHandler(widget.onDoubleTap),
          'onLongPress': DataSourceEncoder.voidHandler(widget.onLongPress),
          'onTapDown': DataSourceEncoder.handler(widget.onTapDown),
          'onTapCancel': DataSourceEncoder.voidHandler(widget.onTapCancel),
          'onTapUp': DataSourceEncoder.handler(widget.onTapUp),
          'onSecondaryTap':
              DataSourceEncoder.voidHandler(widget.onSecondaryTap),
          'onSecondaryTapUp':
              DataSourceEncoder.handler(widget.onSecondaryTapUp),
          'onSecondaryTapDown':
              DataSourceEncoder.handler(widget.onSecondaryTapDown),
          'onSecondaryTapCancel':
              DataSourceEncoder.voidHandler(widget.onSecondaryTapCancel),
          'onHighlightChanged':
              DataSourceEncoder.handler(widget.onHighlightChanged),
          'onHover': DataSourceEncoder.handler(widget.onHover),
          'focusColor': ArgumentEncoders.color(widget.focusColor),
          'hoverColor': ArgumentEncoders.color(widget.hoverColor),
          'highlightColor': ArgumentEncoders.color(widget.highlightColor),
          'splashColor': ArgumentEncoders.color(widget.splashColor),
          'radius': widget.radius,
          'borderRadius': ArgumentEncoders.borderRadius(widget.borderRadius),
          'customBorder': ArgumentEncoders.shapeBorder(widget.customBorder),
          'enableFeedback': widget.enableFeedback,
          'excludeFromSemantics': widget.excludeFromSemantics,
          'autofocus': widget.autofocus,
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class LinearProgressIndicatorVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(LinearProgressIndicator widget) {
    return ConstructorCall(
        'LinearProgressIndicator',
        NotNullMap.from({
          'value': widget.value,
          'color': ArgumentEncoders.color(widget.color),
          'backgroundColor': ArgumentEncoders.color(widget.backgroundColor),
          'minHeight': widget.minHeight,
          'semanticsLabel': ArgumentEncoders.string(widget.semanticsLabel),
          'semanticsValue': ArgumentEncoders.string(widget.semanticsValue),
        }));
  }
}

class ListTileVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(ListTile widget) {
    return ConstructorCall(
      'ListTile',
      NotNullMap.from({
        'leading': ArgumentEncoders.widget(widget.leading),
        'title': ArgumentEncoders.widget(widget.title),
        'subtitle': ArgumentEncoders.widget(widget.subtitle),
        'trailing': ArgumentEncoders.widget(widget.trailing),
        'isThreeLine': widget.isThreeLine,
        'dense': widget.dense,
        'visualDensity': ArgumentEncoders.visualDensity(widget.visualDensity),
        'shape': ArgumentEncoders.shapeBorder(widget.shape),
        'contentPadding': ArgumentEncoders.edgeInsets(widget.contentPadding),
        'enabled': widget.enabled,
        'onTap': DataSourceEncoder.voidHandler(widget.onTap),
        'onLongPress': DataSourceEncoder.voidHandler(widget.onLongPress),
        'selected': widget.selected,
        'focusColor': ArgumentEncoders.color(widget.focusColor),
        'hoverColor': ArgumentEncoders.color(widget.hoverColor),
        'autofocus': widget.autofocus,
        'tileColor': ArgumentEncoders.color(widget.tileColor),
        'selectedTileColor': ArgumentEncoders.color(widget.selectedTileColor),
        'enableFeedback': widget.enableFeedback,
        'horizontalTitleGap': widget.horizontalTitleGap,
        'minVerticalPadding': widget.minVerticalPadding,
        'minLeadingWidth': widget.minLeadingWidth,
      }),
    );
  }
}

class MaterialVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(Material widget) {
    return ConstructorCall(
        'Material',
        NotNullMap.from({
          'type': ArgumentEncoders.enumValue(widget.type),
          'elevation': widget.elevation,
          'color': ArgumentEncoders.color(widget.color),
          'shadowColor': ArgumentEncoders.color(widget.shadowColor),
          'surfaceTintColor': ArgumentEncoders.color(widget.surfaceTintColor),
          'textStyle': ArgumentEncoders.textStyle(widget.textStyle),
          'borderRadius': ArgumentEncoders.borderRadius(widget.borderRadius),
          'shape': ArgumentEncoders.shapeBorder(widget.shape),
          'borderOnForeground': widget.borderOnForeground,
          'clipBehavior': widget.clipBehavior,
          'animationDuration':
              ArgumentEncoders.duration(widget.animationDuration),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class OutlinedButtonVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(OutlinedButton widget) {
    return ConstructorCall(
      'OutlinedButton',
      NotNullMap.from({
        'onPressed': DataSourceEncoder.voidHandler(widget.onPressed),
        'onLongPress': DataSourceEncoder.voidHandler(widget.onLongPress),
        'autofocus': widget.autofocus,
        'clipBehavior': ArgumentEncoders.enumValue(widget.clipBehavior),
        'child': ArgumentEncoders.widget(widget.child),
      }),
    );
  }
}

class ScaffoldVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(Scaffold widget) {
    return ConstructorCall(
      'Scaffold',
      NotNullMap.from({
        'appBar': ArgumentEncoders.widget(widget.appBar),
        'body': ArgumentEncoders.widget(widget.body),
        'floatingActionButton':
            ArgumentEncoders.widget(widget.floatingActionButton),
        'persistentFooterButtons':
            ArgumentEncoders.widgetList(widget.persistentFooterButtons),
        'drawer': ArgumentEncoders.widget(widget.drawer),
        'endDrawer': ArgumentEncoders.widget(widget.endDrawer),
        'bottomNavigationBar':
            ArgumentEncoders.widget(widget.bottomNavigationBar),
        'bottomSheet': ArgumentEncoders.widget(widget.bottomSheet),
        'resizeToAvoidBottomInset': widget.resizeToAvoidBottomInset,
        'primary': widget.primary,
        'drawerDragStartBehavior':
            ArgumentEncoders.enumValue(widget.drawerDragStartBehavior),
        'extendBody': widget.extendBody,
        'extendBodyBehindAppBar': widget.extendBodyBehindAppBar,
        'drawerScrimColor': ArgumentEncoders.color(widget.drawerScrimColor),
        'drawerEdgeDragWidth': widget.drawerEdgeDragWidth,
        'drawerEnableOpenDragGesture': widget.drawerEnableOpenDragGesture,
        'endDrawerEnableOpenDragGesture': widget.endDrawerEnableOpenDragGesture,
        'restorationId': ArgumentEncoders.string(widget.restorationId),
      }),
    );
  }
}

class TextButtonVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(TextButton widget) {
    return ConstructorCall(
        'TextButton',
        NotNullMap.from({
          'onPressed': DataSourceEncoder.voidHandler(widget.onPressed),
          'onLongPress': DataSourceEncoder.voidHandler(widget.onLongPress),
          'autofocus': widget.autofocus,
          'clipBehavior': ArgumentEncoders.enumValue(widget.clipBehavior),
          'child': ArgumentEncoders.widget(widget.child),
        }));
  }
}

class VerticalDividerVisitor implements MaterialWidgetVisitor {
  @override
  ConstructorCall visit(VerticalDivider widget) {
    return ConstructorCall(
        'VerticalDivider',
        NotNullMap.from({
          'width': widget.width,
          'thickness': widget.thickness,
          'indent': widget.indent,
          'endIndent': widget.endIndent,
          'color': ArgumentEncoders.color(widget.color),
        }));
  }
}
