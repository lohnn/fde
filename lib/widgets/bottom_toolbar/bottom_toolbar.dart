import 'package:digital_clock/emoji_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter_desktop_environment/apps/about/about.dart';
import 'package:flutter_desktop_environment/apps/lohnn_web/lohnn_web.dart';
import 'package:flutter_desktop_environment/apps/settings/settings.dart';
import 'package:flutter_desktop_environment/widgets/window/window.dart';
import 'package:text_editor/text_editor.dart';

class BottomToolbar extends StatelessWidget {
  final _borders = const Radius.circular(8);
  final Function(WidgetBuilder) onAppSelected;

  BottomToolbar({Key key, this.onAppSelected}) : super(key: key);

  final List<_App> _apps = [
    _App(
      icon: Icons.info,
      name: "Information about Johannes",
      widgetBuilder: (context) => LohnnWebPage(),
    ),
//    _App(
//      icon: Icons.access_time,
//      name: "Flutter clock challenge",
//      widgetBuilder: (context) => ClockCustomizer((ClockModel model) => EmojiClock(model)),
//    ),
//    _App(
//      icon: Icons.text_format,
//      name: "Text editor",
//      widgetBuilder: (context) => TextEditor(),
//    ),
    _App(
      icon: Icons.settings,
      name: "Settings",
      widgetBuilder: (context) => Settings(),
    ),
    _App(
      icon: Icons.info,
      name: "About",
      widgetBuilder: (context) => AboutPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          boxShadow: [defaultShadow],
          borderRadius: BorderRadius.only(
            topLeft: _borders,
            topRight: _borders,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _apps
              .map((app) => _ToolbarButton(
                    child: Icon(app.icon),
                    onTap: () => onAppSelected(app.widgetBuilder),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _App {
  final IconData icon;
  final WidgetBuilder widgetBuilder;
  final String name;

  const _App({
    @required this.icon,
    @required this.widgetBuilder,
    @required this.name,
  })  : assert(icon != null),
        assert(widgetBuilder != null),
        assert(name != null);
}

class _ToolbarButton extends StatelessWidget {
  final Function onTap;
  final Widget child;

  const _ToolbarButton({Key key, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        color: kIsWeb ? Theme.of(context).primaryColorDark : Colors.transparent,
        child: Listener(
          onPointerDown: (event) {
            if (event.buttons == kSecondaryButton) {
              print("Right click");
              final clickPos = event.position;
              final dx = clickPos.dx;
              final dy = clickPos.dy;
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(dx, dy, dx, dy),
                items: [
                  PopupMenuItem(child: Text("Hejsan")),
                ],
              );
            }
          },
          child: InkWell(
            onTap: onTap,
            child: Container(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
