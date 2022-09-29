// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:easy_nutrition/layout/shared/user_type_page.dart';
import 'package:easy_nutrition/services/patient_services.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Start Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return const UserTypePage();
                }));
              },
              child: Text("Empezar"),
            )
          ],
        ),
      ),
    );
  }
}

void login(BuildContext context) {
  PatientService _patientService = PatientService();
  _patientService.signInWithGoogle(context);
}
