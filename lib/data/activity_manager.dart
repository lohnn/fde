import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/apps/lohnn_web/lohnn_web.dart';
import 'package:uuid/uuid.dart';

class ActivityManager with ChangeNotifier {
  final _uuid = Uuid();
  double _lastX = 24;
  double _lastY = 40;
  int _maxSortIndex = 0;

  List<MapEntry<String, _Temp>> _activities = [];

  Iterable<MapEntry<String, _Temp>> get activities => _activities;

  ActivityManager() {
//    _activities.add(
//      MapEntry(
//        _uuid.v1(),
//        _Temp(
//            child: LohnnWebPage(),
//            startX: _lastX += 20,
//            startY: _lastY += 15,
//            sortIndex: _maxSortIndex++),
//      ),
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
          sortIndex: _maxSortIndex++,
        ),
      ),
    );
    notifyListeners();
  }

  void closeTopActivity() {
    _activities.removeLast();
    notifyListeners();
  }

  void activityToForeground(MapEntry<String, _Temp> entry) {
    entry.value.sortIndex = _maxSortIndex++;
    _activities.sort((a, b) => a.value.sortIndex.compareTo(b.value.sortIndex));
    notifyListeners();
  }
}

class _Temp {
  final Widget child;
  int sortIndex;
  final double startX;
  final double startY;

  _Temp({
    @required this.child,
    @required this.startX,
    @required this.startY,
    @required this.sortIndex,
  });
}
