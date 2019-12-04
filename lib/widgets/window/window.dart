import 'package:flutter/material.dart';

import 'toolbar.dart';

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

const defaultShadow = const BoxShadow(
  blurRadius: 8,
  color: Colors.black26,
);

class _WindowState extends State<Window> {
  double xPos;
  double yPos;
  double width;
  double height;

  _WindowState({
    this.xPos = 24,
    this.yPos = 40,
    this.width = 600,
    this.height = 400,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: xPos,
      top: yPos,
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [defaultShadow],
          borderRadius: BorderRadius.circular(5),
        ),
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
                onWindowMoved: (details) => setState(() {
                  final delta = details.delta;
                  xPos += delta.dx;
                  yPos += delta.dy;
                }),
                onQuitTapped: widget.onQuitTapped,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              height: 16,
              width: 16,
              child: ResizeGrabber(
                onDragged: (details) => setState(() {
                  final delta = details.delta;
                  width += delta.dx;
                  height += delta.dy;
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResizeGrabber extends StatelessWidget {
  final GestureDragUpdateCallback onDragged;

  const ResizeGrabber({Key key, this.onDragged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onDragged,
      child: Container(color: Colors.transparent),
    );
  }
}
