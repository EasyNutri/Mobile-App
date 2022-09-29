// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, use_build_context_synchronously, avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_nutrition/data/patient.dart';
import 'package:easy_nutrition/layout/patient/auth/patient_register.dart';
import 'package:easy_nutrition/layout/patient/patient_tab.dart';
import 'package:easy_nutrition/layout/shared/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class PatientService {
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
          final docRef = db.collection("patients").doc(value.user!.uid);
          await docRef.get().then(
            (DocumentSnapshot doc) async {
              if (doc.exists) {
                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return PatientTabs();
                }));
              } else {
                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return PatientRegister();
                }));
              }
            },
            onError: (e) => print(
                "Error al intentar obtener doc ${value.user!.uid} en patient"),
          );
        } catch (e) {
          print(e);
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void signOutPatient(BuildContext context) async {
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

  void createPatient(String id, String firstName, String lastName, String email,
      String phoneNumber, String photoUrl, BuildContext context) async {
    final patient = Patient(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl);

    final docRef = db
        .collection("patients")
        .withConverter(
          fromFirestore: Patient.fromFirestore,
          toFirestore: (Patient patient, options) => patient.toFirestore(),
        )
        .doc(id);
    await docRef.set(patient).then((value) => Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return const PatientTabs();
        })));
  }

  Future<Patient> getPatient(String uid) async {
    Patient patient;
    var firstName = "";
    var lastName = "";
    var email = "";
    var phoneNumber = "";
    var photoUrl = "";

    try {
      final docRef = db.collection("patients").doc(uid);
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          firstName = data["firstName"];
          lastName = data["lastName"];
          email = data["email"];
          phoneNumber = data["phoneNumber"];
          photoUrl = data["photoUrl"];
        },
        onError: (e) => print("Error al intentar obtener doc $uid en patient"),
      );
    } catch (e) {
      print(e);
    }
    return patient = Patient(
        id: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl);
  }
}
