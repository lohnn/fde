import 'package:flutter/material.dart';

class TextAlertDialog extends StatefulWidget {
  final String defaultText;

  const TextAlertDialog({Key key, this.defaultText: ""}) : super(key: key);

  @override
  _TextAlertDialogState createState() => _TextAlertDialogState();
}

class _TextAlertDialogState extends State<TextAlertDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.defaultText;
    _controller.selection =
        TextSelection(baseOffset: 0, extentOffset: widget.defaultText.length);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Username"),
      content: TextField(
        autofocus: true,
        controller: _controller,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              Navigator.of(context).pop(_controller.text);
            }
          },
        ),
      ],
    );
  }
}
