import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ActivityManager with ChangeNotifier {
  final _uuid = Uuid();
  double _lastX = 24;
  double _lastY = 40;

  List<MapEntry<String, _Temp>> _activities = [];

  Iterable<MapEntry<String, _Temp>> get activities => _activities;

  ActivityManager() {
//    _windows[_uuid.v1()] = _Temp(
//      child: LohnnWebPage(),
//      startX: _lastX += 20,
//      startY: _lastY += 15,
//    );
  }

  void closeActivity(String windowId) {
    _activities.removeWhere((entry) => entry.key == windowId);
    notifyListeners();
  }

  void startActivity(Widget widget) {
    _activities.add(
      MapEntry(
        _uuid.v1(),
        _Temp(
          child: widget,
          startX: _lastX += 20,
          startY: _lastY += 15,
        ),
      ),
    );
    print("Windows now ${_activities.length}");
    notifyListeners();
  }

  void closeTopActivity() {
    _activities.removeLast();
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
