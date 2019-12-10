import 'package:flutter/material.dart';
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
