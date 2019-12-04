import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/widgets/window.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _windows = [
    Container(color: Colors.greenAccent),
  ];

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
            for (Widget child in _windows)
              Window(
                onQuitTapped: () => setState(() {
                  _windows.remove(child);
                }),
                child: child,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _windows.add(Container(color: Colors.orange));
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
