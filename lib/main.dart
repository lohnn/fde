import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/apps/lohnn_web/lohnn_web.dart';
import 'package:flutter_desktop_environment/widgets/window/window.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
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
      child: LohnnWebPage(),
      startX: _lastX += 20,
      startY: _lastY += 15,
    );
    super.initState();
  }

  double _lastX = 24;
  double _lastY = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.network(
              "http://www.technocrazed.com/wp-content/uploads/2015/12/Linux-Wallpaper-31.jpg",
            ).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text('This is your new desktop environment'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _windows[_uuid.v1()] = _Temp(
            child: LohnnWebPage(),
            startX: _lastX += 20,
            startY: _lastY += 15,
          );
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
