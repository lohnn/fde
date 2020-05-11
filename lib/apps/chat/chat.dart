import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_environment/apps/chat/data/message.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  final String username;

  const Chat({Key key, @required this.username})
      : assert(username != null),
        super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  CollectionReference messages;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd – kk:mm');
  final TextEditingController textController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();

  @override
  void initState() {
    Firestore store = Firestore.instance;
    messages = store.collection('chat').document("hashcode").collection("messages");

    messages.snapshots().listen((snapshot) {
      print("Hejsan");
      print(snapshot.documents.length);
      print(snapshot.documents);
      snapshot.documents.forEach((doc) {
        print(doc.data);
      });
    });
    super.initState();
  }

  sendMessage() {
    String text = textController.text;
    if (text == null || text.isEmpty) return;
    final message = Message(
      sender: widget.username,
      message: text,
    );
    messages.add(message.toJson());
    textController.clear();
    textFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messages.orderBy("time", descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  final data = snapshot.data;
                  return ListView.builder(
                    reverse: true,
                    itemCount: data.documents.length,
                    itemBuilder: (context, index) {
                      final message = Message.fromJson(data.documents[index].data);
                      return ListTile(
                        title: Text(
                            "${message.sender} - ${dateFormat.format(message.time.toDate())}"),
                        subtitle: Text(
                          message.message,
                          style: Theme.of(context).textTheme.body1,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
                  child: TextField(
                    autofocus: true,
                    onSubmitted: (_) => sendMessage(),
                    focusNode: textFocusNode,
                    controller: textController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.5),
                      filled: true,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
