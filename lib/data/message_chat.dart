import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChat {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  MessageChat(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      "idFrom": idFrom,
      "idTo": idTo,
      "timestamp": timestamp,
      "content": content,
      "type": type,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    return MessageChat(
        idFrom: doc.get("idFrom"),
        idTo: doc.get("idTo"),
        timestamp: doc.get("timestamp"),
        content: doc.get("content"),
        type: doc.get("type"));
  }
}
