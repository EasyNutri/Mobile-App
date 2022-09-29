// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:easy_nutrition/services/patient_services.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                logOut(context);
              },
              child: Text("Cerrar sesión"),
            ),
          ],
        ),
      ),
    );
  }
}

void logOut(BuildContext context) {
  PatientService _patientServices = PatientService();
  _patientServices.signOutPatient(context);
}
