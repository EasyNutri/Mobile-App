// ignore_for_file: prefer_const_constructors, unused_field, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String anotherUserId;
  final String anotherUserName;
  final String anotherUserPhotoUrl;
  const ChatPage(
      {super.key,
      required this.anotherUserId,
      required this.anotherUserName,
      required this.anotherUserPhotoUrl});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.anotherUserPhotoUrl),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.anotherUserName,
                    ),
                  ],
                ),
              )
            ],
          )),
      body: Center(
        child: Text("Chat Page"),
      ),
    );
  }
}
