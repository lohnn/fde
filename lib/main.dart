import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/data/activity_manager.dart';
import 'package:flutter_desktop_environment/widgets/box_opener.dart';
import 'package:flutter_desktop_environment/widgets/desktop_modes/fullscreen.dart';
import 'package:flutter_desktop_environment/widgets/desktop_modes/windowed.dart';
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
    return BoxOpener(
      boxNames: ["settings"],
      onSuccess: (context) {
        return WatchBoxBuilder(
          box: Hive.box("settings"),
          builder: (context, settings) => MaterialApp(
            title: 'Flutter Demo',
            theme: settings.get("dark_mode", defaultValue: true)
                ? ThemeData.dark()
                : ThemeData(),
            initialRoute: "/",
            routes: {
              "/": (context) => MyHomePage(),
              "/clock": (context) => MyHomePage(
                    defaultApps: ["clock"],
                  ),
            },
//            onGenerateRoute: (settings) {
//              List<String> defaultApps = [];
//                if(settings.name == "/clock")
//                  defaultApps.add("clock");
//              return MaterialPageRoute(
//                builder: (context) => MyHomePage(defaultApps: defaultApps,),
//                settings: settings,
//              );
//            },
//              home: MyHomePage(),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> defaultApps;

  const MyHomePage({Key key, this.defaultApps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActivityManager(defaultApps: defaultApps)),
      ],
      child: WatchBoxBuilder(
        box: Hive.box("settings"),
        builder: (context, settings) => LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600 || constraints.maxHeight < 600) {
              return FullScreen(settings);
            } else {
              return Windowed(settings);
            }
          },
        ),
      ),
    );
  }
}
