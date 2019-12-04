import 'package:flutter/material.dart';

class Window extends StatefulWidget {
  final Widget child;
  final Function onQuitTapped;
  static const _topBarHeight = 24.0;
  final double startX;
  final double startY;

  const Window({
    Key key,
    @required this.child,
    this.onQuitTapped,
    this.startX,
    this.startY,
  })  : assert(child != null),
        super(key: key);

  @override
  _WindowState createState() => _WindowState(xPos: startX, yPos: startY);
}

class _WindowState extends State<Window> {
  double xPos;
  double yPos;

  _WindowState({
    this.xPos = 24,
    this.yPos = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: xPos,
      top: yPos,
      height: 194,
      width: 291,
      child: Stack(
        children: [
          Positioned(
            top: Window._topBarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: widget.child,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: Window._topBarHeight,
            child: TopBar(
              onWindowMoved: (details) {
                setState(() {
                  final delta = details.delta;
                  xPos += delta.dx;
                  yPos += delta.dy;
                });
              },
              onQuitTapped: widget.onQuitTapped,
            ),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final Function onQuitTapped;
  final GestureDragUpdateCallback onWindowMoved;

  TopBar({
    Key key,
    this.onQuitTapped,
    this.onWindowMoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onWindowMoved,
      child: Container(
        color: Colors.purple,
        child: Row(
          children: <Widget>[
            SmallButton(
              onTapped: onQuitTapped,
            ),
          ],
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final Function onTapped;

  const SmallButton({Key key, this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        height: 24,
        width: 24,
        color: Colors.redAccent,
        child: Icon(Icons.close),
      ),
    );
  }
}
