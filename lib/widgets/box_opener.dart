import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

typedef ErrorBuilder = Widget Function(BuildContext context, String error);

/// A widget that can open multiple boxes at the same time.
class BoxOpener extends StatefulWidget {
  final List<String> boxNames;
  final WidgetBuilder onSuccess;
  final ErrorBuilder onError;
  final WidgetBuilder onLoading;

  const BoxOpener({
    Key key,
    @required this.boxNames,
    @required this.onSuccess,
    this.onError,
    this.onLoading,
  })  : assert(boxNames != null),
        assert(onSuccess != null),
        super(key: key);

  @override
  _BoxOpenerState createState() => _BoxOpenerState();
}

class _BoxOpenerState extends State<BoxOpener> {
  Widget _stateWidget;

  set _currentWidget(Widget widget) {
    setState(() {
      _stateWidget = widget;
    });
  }

  @override
  void dispose() {
    print("Closing boxes ${widget.boxNames}");
    widget.boxNames.forEach((name) => Hive.box(name).close());
    super.dispose();
  }

  @override
  void initState() {
    print("Opening boxes ${widget.boxNames}");
    _startLoading();
    super.initState();
  }

  void _startLoading() async {
    if (widget.onLoading != null) {
      _currentWidget = widget.onLoading(context);
    }
    _currentWidget = Container();

    try {
      await Future.wait(widget.boxNames.map((name) => Hive.openBox(name)));
      _currentWidget = widget.onSuccess(context);
    } catch (error) {
      if (widget.onError != null) {
        _currentWidget = widget.onError(context, error.toString());
      }
      _currentWidget = Text(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) => _stateWidget;
}
