import 'package:cloud_firestore/cloud_firestore.dart';

class Nutritionist {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? photoUrl;

  const Nutritionist({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.photoUrl,
  });

  factory Nutritionist.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Nutritionist(
        id: data?['id'],
        firstName: data?['firstName'],
        lastName: data?['lastName'],
        email: data?['email'],
        password: data?['password'],
        phoneNumber: data?['phoneNumber'],
        photoUrl: data?['photoUrl']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (photoUrl != null) "photoUrl": photoUrl
    };
  }
}
