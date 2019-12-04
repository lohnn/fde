import 'package:flutter/material.dart';

import 'window.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: _InnerSmallButton(),
      ),
    );
  }
}

class _InnerSmallButton extends StatefulWidget {
  @override
  __InnerSmallButtonState createState() => __InnerSmallButtonState();
}

class __InnerSmallButtonState extends State<_InnerSmallButton> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isFocused = true),
      onExit: (_) => setState(() => _isFocused = false),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isFocused ? Colors.red.shade700 : Colors.red.shade400,
            boxShadow: [defaultShadow]),
        height: 20,
        width: 20,
        child: Icon(
          Icons.close,
          size: 16,
        ),
      ),
    );
  }
}
