import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
              value: settings.get("dark_mode", defaultValue: true),
              onChanged: (value) => settings.put("dark_mode", value),
              title: Text("Dark mode"),
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  child: AlertDialog(
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: Color(settings.get("backgroind_tint",
                            defaultValue: Colors.orange.value)),
                        onColorChanged: (color) =>
                            settings.put("backgroind_tint", color.value),
                        enableLabel: true,
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
              title: Text("Background color tint"),
            )
          ],
        ),
      ),
    );
  }
}
