import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/widgets/window/window.dart';
import 'package:uuid/uuid.dart';

class ActivityManager with ChangeNotifier {
  final _uuid = Uuid();
  double _lastX = 24;
  double _lastY = 40;

  Map<String, _Temp> _windows = {};

  Iterable<Window> get windows => _windows
      .map((key, temp) => MapEntry(
            key,
            Window(
              key: Key(key),
              startX: temp.startX,
              startY: temp.startY,
              onQuitTapped: () => closeActivity(key),
              child: temp.child,
            ),
          ))
      .values;

  ActivityManager() {
//    _windows[_uuid.v1()] = _Temp(
//      child: LohnnWebPage(),
//      startX: _lastX += 20,
//      startY: _lastY += 15,
//    );
  }

  void closeActivity(String windowId) {
    _windows.remove(windowId);
    notifyListeners();
  }

  void startActivity(Widget widget) {
    _windows[_uuid.v1()] = _Temp(
      child: widget,
      startX: _lastX += 20,
      startY: _lastY += 15,
    );
    print("Windows now ${_windows.length}");
    notifyListeners();
  }
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
