import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/apps/lohnn_web/lohnn_web.dart';
import 'package:flutter_desktop_environment/widgets/settings/settings.dart';
import 'package:flutter_desktop_environment/widgets/window/window.dart';

class BottomToolbar extends StatelessWidget {
  final _borders = const Radius.circular(8);
  final Function(WidgetBuilder) onAppSelected;

  BottomToolbar({Key key, this.onAppSelected}) : super(key: key);

  final List<_App> _apps = [
    _App(Icons.info, (context) => LohnnWebPage()),
    _App(Icons.settings, (context) => Settings()),
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

  const _App(this.icon, this.widgetBuilder);
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
        child: InkWell(
          onTap: onTap,
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}
