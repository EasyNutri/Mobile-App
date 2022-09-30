// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, use_build_context_synchronously, avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_nutrition/data/nutritionist.dart';
import 'package:easy_nutrition/layout/nutritionist/auth/nutritionist_register.dart';
import 'package:easy_nutrition/layout/shared/start_page.dart';
import 'package:easy_nutrition/layout/shared/tabs.dart';
import 'package:easy_nutrition/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final UserService _userService = UserService();

class NutritionistService {
  final db = FirebaseFirestore.instance;

  void signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await _auth.signInWithCredential(credential).then((value) async {
        try {
          final docRef = db.collection("nutritionists").doc(value.user!.uid);
          await docRef.get().then(
            (DocumentSnapshot doc) async {
              if (doc.exists) {
                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Tabs();
                }));
              } else {
                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return NutritionistRegister();
                }));
              }
            },
            onError: (e) => print(
                "Error al intentar obtener doc ${value.user!.uid} en nutritionist"),
          );
        } catch (e) {
          print(e);
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void signOutNutritionist(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (BuildContext context) {
        return const StartPage();
      }));
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void createNutritionist(
      String id,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String photoUrl,
      BuildContext context) async {
    String name = firstName + lastName;
    _userService.createUser(id, name, "nutritionist", photoUrl);
    final nutritionist = Nutritionist(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl);

    final docRef = db
        .collection("nutritionists")
        .withConverter(
          fromFirestore: Nutritionist.fromFirestore,
          toFirestore: (Nutritionist nutritionist, options) =>
              nutritionist.toFirestore(),
        )
        .doc(id);
    await docRef.set(nutritionist).then((value) => Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return Tabs();
        })));
  }

  Future<Nutritionist> getNutritionist(String uid) async {
    Nutritionist nutritionist;
    var firstName = "";
    var lastName = "";
    var email = "";
    var phoneNumber = "";
    var photoUrl = "";

    try {
      final docRef = db.collection("nutritionists").doc(uid);
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          firstName = data["firstName"];
          lastName = data["lastName"];
          email = data["email"];
          phoneNumber = data["phoneNumber"];
          photoUrl = data["photoUrl"];
        },
        onError: (e) =>
            print("Error al intentar obtener doc $uid en nutritionist"),
      );
    } catch (e) {
      print(e);
    }
    return nutritionist = Nutritionist(
        id: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl);
  }
}
