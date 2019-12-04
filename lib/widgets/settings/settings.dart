import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WatchBoxBuilder(
        box: Hive.box("settings"),
        builder: (context, settings) => Column(
          children: <Widget>[
            SwitchListTile.adaptive(
              value: settings.get("dark_mode", defaultValue: false),
              onChanged: (value) {
                print("Dark mode is $value");
                return settings.put("dark_mode", value);
              },
              title: Text("Dark mode"),
            ),
          ],
        ),
      ),
    );
  }
}
