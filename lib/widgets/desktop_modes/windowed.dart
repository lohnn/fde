import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_desktop_environment/data/activity_manager.dart';
import 'package:flutter_desktop_environment/widgets/bottom_toolbar/bottom_toolbar.dart';
import 'package:flutter_desktop_environment/widgets/window/window.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class Windowed extends StatefulWidget {
  final Box _settings;

  Windowed(this._settings);

  @override
  _WindowedState createState() => _WindowedState();
}

class _WindowedState extends State<Windowed> {
  bool _isFullScreen = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityManager>(
      builder: (context, activityManager, _) => Scaffold(
        appBar: AppBar(
          leading: _isFullScreen
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    activityManager.closeTopActivity();
                  },
                )
              : null,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(
                "http://www.technocrazed.com/wp-content/uploads/2015/12/Linux-Wallpaper-31.jpg",
              ).image,
              colorFilter: ColorFilter.mode(
                  Color(
                    widget._settings.get(
                      "backgroind_tint",
                      defaultValue: Colors.orange.value,
                    ),
                  ),
                  BlendMode.color),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Listener(
                  onPointerDown: (event) async {
                    if (event.buttons == kSecondaryButton) {
                      final clickPos = event.position;
                      final dx = clickPos.dx;
                      final dy = clickPos.dy;
                      final menuResult = await showMenu<String>(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx, dy),
                        items: [
                          CheckedPopupMenuItem(
                            child: Text("Dark mode"),
                            value: "darkmode",
                            checked: widget._settings.get("dark_mode") ?? true,
                          ),
                          if (!kIsWeb)
                            PopupMenuItem(
                              child: Text("Set background tint"),
                              value: "backgroundTint",
                            ),
                        ],
                      );
                      menuResult.when({
                        "darkmode": () {
                          widget._settings.put("dark_mode",
                              !(widget._settings.get("dark_mode") ?? true));
                        },
                        "backgroundTint": () {
                          showDialog(
                            context: context,
                            child: AlertDialog(
                              title: const Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: Color(widget._settings.get(
                                      "backgroind_tint",
                                      defaultValue: Colors.orange.value)),
                                  onColorChanged: (color) => widget._settings
                                      .put("backgroind_tint", color.value),
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      });
                    }
                  },
                  child: Container(color: Colors.transparent),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomToolbar(
                  onAppSelected: (widgetBuilder) {
                    activityManager.startActivity(widgetBuilder(context));
                  },
                ),
              ),
              ...activityManager.activities.map((entry) => Window(
                    key: Key(entry.key),
                    child: entry.value.child,
                    startX: entry.value.startX,
                    startY: entry.value.startY,
                    onQuitTapped: () =>
                        activityManager.closeActivity(entry.key),
                    onWindowInteracted: () {
                      activityManager.activityToForeground(entry);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

extension When<T> on dynamic {
  when(Map<T, Function> whens, {Function onDefault}) {
    if (whens.containsKey(this)) {
      whens[this]();
    } else if (onDefault != null) {
      onDefault();
    }
  }
}
