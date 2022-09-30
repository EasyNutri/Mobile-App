// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String id;
  final String name;
  final String userType;
  final String photoUrl;

  const MyUser(
      {required this.id,
      required this.name,
      required this.userType,
      required this.photoUrl});

  factory MyUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MyUser(
        id: data?['id'],
        name: data?['name'],
        userType: data?['userType'],
        photoUrl: data?['photoUrl']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (userType != null) "userType": userType,
      if (photoUrl != null) "photoUrl": photoUrl
    };
  }
}
