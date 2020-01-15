import 'package:flutter/material.dart';

import 'toolbar.dart';

class Window extends StatefulWidget {
  final Widget child;
  final Function onQuitTapped;
  final Function onWindowInteracted;
  static const _topBarHeight = 24.0;
  final double startX;
  final double startY;

  const Window({
    Key key,
    @required this.child,
    this.onQuitTapped,
    this.onWindowInteracted,
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
      child: GestureDetector(
        onTapDown: (_) {
          widget.onWindowInteracted();
        },
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
      child: CustomPaint(
        key: Key("grabber"),
        painter: _ResizeGrabberPainter(),
      ),
    );
  }
}

class _ResizeGrabberPainter extends CustomPainter {
  static const _radius = 1.25;
    static final _paint = Paint()..color = Colors.white.withAlpha(100);

  @override
  void paint(Canvas canvas, Size size) {
    //Top right
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.25),
      _radius,
      _paint,
    );

    //Center
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      _radius,
      _paint,
    );

    //Bottom right
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.75),
      _radius,
      _paint,
    );

    //Bottom left
    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.75),
      _radius,
      _paint,
    );

    //Center left
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.75),
      _radius,
      _paint,
    );

    //Bottom center
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.50),
      _radius,
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
