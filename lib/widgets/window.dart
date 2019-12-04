import 'package:flutter/material.dart';

class Window extends StatelessWidget {
  final Widget child;
  final Function onQuitTapped;
  static const _topBarHeight = 24.0;

  const Window({Key key, @required this.child, this.onQuitTapped})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 24,
      height: 194,
      width: 291,
      child: Stack(
        children: [
          Positioned(
            top: _topBarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: child,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _topBarHeight,
            child: TopBar(
              onQuitTapped: onQuitTapped,
            ),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final Function onQuitTapped;

  TopBar({Key key, this.onQuitTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Row(
        children: <Widget>[
          SmallButton(
            onTapped: onQuitTapped,
          ),
        ],
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
