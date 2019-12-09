import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/data/activity_manager.dart';
import 'package:flutter_desktop_environment/widgets/bottom_toolbar/bottom_toolbar.dart';
import 'package:flutter_desktop_environment/widgets/box_opener.dart';
import 'package:flutter_desktop_environment/widgets/window/window.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDirectory =
        await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActivityManager()),
      ],
      child: BoxOpener(
        boxNames: ["settings"],
        onSuccess: (context) {
          return WatchBoxBuilder(
            box: Hive.box("settings"),
            builder: (context, settings) => MaterialApp(
              title: 'Flutter Demo',
              theme: settings.get("dark_mode", defaultValue: true)
                  ? ThemeData.dark()
                  : ThemeData(),
              home: MyHomePage(),
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WatchBoxBuilder(
        box: Hive.box("settings"),
        builder: (context, settings) => LayoutBuilder(
          builder: (context, constraints) {
            return Windowed(settings);
          },
        ),
      ),
    );
  }
}

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
        builder: (BuildContext context, ActivityManager activityManager,
                Widget child) =>
            Stack(
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
            ...activityManager.windows
                .map((key, temp) => MapEntry(
                      key,
                      Window(
                        key: Key(key),
                        startX: temp.startX,
                        startY: temp.startY,
                        onQuitTapped: () => activityManager.closeActivity(key),
                        child: temp.child,
                      ),
                    ))
                .values,
          ],
        ),
      ),
    );
  }
}
