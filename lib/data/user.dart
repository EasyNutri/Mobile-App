import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String? id;
  final String? userType;
  final String? photoUrl;

  const MyUser({this.id, this.userType, this.photoUrl});

  factory MyUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MyUser(
        id: data?['id'],
        userType: data?['userType'],
        photoUrl: data?['photoUrl']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (userType != null) "userType": userType,
      if (photoUrl != null) "photoUrl": photoUrl
    };
  }
}
