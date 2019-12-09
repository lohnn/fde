import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/widgets/window/window.dart';
import 'package:uuid/uuid.dart';

class ActivityManager with ChangeNotifier {
  final _uuid = Uuid();
  double _lastX = 24;
  double _lastY = 40;

  List<MapEntry<String, _Temp>> _windows = [];

  Iterable<Window> get windows => _windows.map(
        (entry) => Window(
          key: Key(entry.key),
          startX: entry.value.startX,
          startY: entry.value.startY,
          onQuitTapped: () => closeActivity(entry.key),
          child: entry.value.child,
        ),
      );

  ActivityManager() {
//    _windows[_uuid.v1()] = _Temp(
//      child: LohnnWebPage(),
//      startX: _lastX += 20,
//      startY: _lastY += 15,
//    );
  }

  void closeActivity(String windowId) {
    _windows.removeWhere((entry) => entry.key == windowId);
    notifyListeners();
  }

  void startActivity(Widget widget) {
    _windows.add(
      MapEntry(
        _uuid.v1(),
        _Temp(
          child: widget,
          startX: _lastX += 20,
          startY: _lastY += 15,
        ),
      ),
    );
    print("Windows now ${_windows.length}");
    notifyListeners();
  }

  void closeTopActivity() {
    _windows.removeLast();
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
