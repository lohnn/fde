import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String sender;
  final String message;
  final Timestamp time;

  Message({
    @required this.sender,
    @required this.message,
    Timestamp time,
  })  : assert(sender != null),
        assert(message != null),
        this.time = time ?? DateTime.now();

  static Message fromJson(Map json) => Message(
        sender: json["sender"],
        message: json["message"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "message": message,
        "time": time,
      };
}
