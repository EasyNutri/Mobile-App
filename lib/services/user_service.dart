// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, use_build_context_synchronously, avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors, unused_local_variable, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_nutrition/data/user.dart';
import 'package:flutter/material.dart';

class UserService {
  final db = FirebaseFirestore.instance;

  void createUser(
      String id, String name, String userType, String photoUrl) async {
    final user =
        MyUser(id: id, name: name, userType: userType, photoUrl: photoUrl);

    final docRef = db
        .collection("users")
        .withConverter(
          fromFirestore: MyUser.fromFirestore,
          toFirestore: (MyUser user, options) => user.toFirestore(),
        )
        .doc(id);
    await docRef.set(user).then((value) {});
  }

  Future<MyUser> getUser(String uid) async {
    MyUser user;
    var name = "";
    var userType = "";
    var photoUrl = "";

    try {
      final docRef = db.collection("users").doc(uid);
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          name = data["name"];
          userType = data["userType"];
          photoUrl = data["photoUrl"];
        },
        onError: (e) => print("Error al intentar obtener doc $uid en user"),
      );
    } catch (e) {
      print(e);
    }
    return user =
        MyUser(id: uid, name: name, userType: userType, photoUrl: photoUrl);
  }

  Future<List<MyUser>> getAllUser() async {
    List<MyUser> userList = [];
    MyUser user;

    try {
      await db.collection("users").get().then((event) {
        for (var doc in event.docs) {
          user = MyUser(
              id: doc.data()["id"],
              name: doc.data()["name"],
              photoUrl: doc.data()["photoUrl"],
              userType: doc.data()["userType"]);
          userList.add(user);
        }
      });
    } catch (e) {
      print(e);
    }

    print(userList);
    return userList;
  }
}
