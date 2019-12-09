import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/data/activity_manager.dart';
import 'package:flutter_desktop_environment/widgets/bottom_toolbar/bottom_toolbar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class Windowed extends StatelessWidget {
  final Box _settings;

  Windowed(this._settings);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.network(
            "http://www.technocrazed.com/wp-content/uploads/2015/12/Linux-Wallpaper-31.jpg",
          ).image,
          colorFilter: ColorFilter.mode(
              Color(_settings.get("backgroind_tint",
                  defaultValue: Colors.orange.value)),
              BlendMode.color),
          fit: BoxFit.cover,
        ),
      ),
      child: Consumer<ActivityManager>(
        builder: (context, activityManager, _) => Stack(
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
            ...activityManager.windows,
          ],
        ),
      ),
    );
  }
}
