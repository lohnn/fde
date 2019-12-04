import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/widgets/bottom_toolbar/bottom_toolbar.dart';
import 'package:flutter_desktop_environment/widgets/box_opener.dart';
import 'package:flutter_desktop_environment/widgets/settings/settings.dart';
import 'package:flutter_desktop_environment/widgets/window/window.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
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
            theme: settings.get("dark_mode", defaultValue: false)
                ? ThemeData.dark()
                : ThemeData(),
            home: MyHomePage(),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _Temp {
  final Widget child;
  final double startX;
  final double startY;

  _Temp({
    @required this.child,
    @required this.startX,
    @required this.startY,
  });
}

class _MyHomePageState extends State<MyHomePage> {
  final _uuid = Uuid();
  Map<String, _Temp> _windows = {};

  @override
  void initState() {
    _windows[_uuid.v1()] = _Temp(
//      child: LohnnWebPage(),
      child: Settings(),
      startX: _lastX += 20,
      startY: _lastY += 15,
    );
    super.initState();
  }

  double _lastX = 24;
  double _lastY = 40;

  @override
  Widget build(BuildContext context) {
    Box settings = Hive.box("settings");
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.network(
              "http://www.technocrazed.com/wp-content/uploads/2015/12/Linux-Wallpaper-31.jpg",
            ).image,
            colorFilter: ColorFilter.mode(
                settings.get("backgroind_tint") ?? Colors.orange,
                BlendMode.color),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text('This is your new desktop environment'),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomToolbar(
                onAppSelected: (widgetBuilder) {
                  setState(() {
                    _windows[_uuid.v1()] = _Temp(
                      child: widgetBuilder(context),
                      startX: _lastX += 20,
                      startY: _lastY += 15,
                    );
                  });
                  print("Windows now ${_windows.length}");
                },
              ),
            ),
            ..._windows
                .map(
                  (key, temp) => MapEntry(
                    key,
                    Window(
                      key: Key(key),
                      startX: temp.startX,
                      startY: temp.startY,
                      onQuitTapped: () => setState(() {
                        _windows.remove(key);
                      }),
                      child: temp.child,
                    ),
                  ),
                )
                .values,
          ],
        ),
      ),
    );
  }
}
