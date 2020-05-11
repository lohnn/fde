import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/apps/chat/chat.dart';
import 'package:flutter_desktop_environment/apps/chat/text_alert_dialog.dart';
import 'package:hive/hive.dart';

class ChatPrereq extends StatefulWidget {
  @override
  _ChatPrereqState createState() => _ChatPrereqState();
}

class _ChatPrereqState extends State<ChatPrereq> {
  String username;

  @override
  void dispose() {
    print("Closing box chat");
    Hive.box("chat").close();
    super.dispose();
  }

  @override
  void initState() {
    print("Opening box chat");
    _setupChatPrereq();
    super.initState();
  }

  Future _setupChatPrereq() async {
    final box = await Hive.openBox("chat");
    String username = box.get("username");
    if (_usernameInvalid(username)) {
      username = await showDialog<String>(
        context: context,
        builder: (context) => TextAlertDialog(),
      );
      if(_usernameInvalid(username)) {
        Navigator.of(context).pop();
      }
    }
    box.put("username", username);
    setState(() {
      this.username = username;
    });
  }

  bool _usernameInvalid(String username) {
    return username == null || username.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    if (_usernameInvalid(username)) {
      return Material();
    }
    return Chat(username: username);
  }
}
