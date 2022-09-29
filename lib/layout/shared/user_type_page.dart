// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:easy_nutrition/layout/patient/auth/patient_register.dart';
import 'package:easy_nutrition/layout/shared/tabs.dart';
import 'package:easy_nutrition/services/nutritionist_services.dart';
import 'package:easy_nutrition/services/patient_services.dart';
import 'package:flutter/material.dart';

import '../../utilities/designs.dart';

class UserTypePage extends StatelessWidget {
  const UserTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            //Texto
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 15, left: 20, right: 20),
              child: Column(
                children: [
                  Text(
                    "¿Que tipo de usuario eres?",
                    style: kHeading3,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 60, right: 60, top: 10, bottom: 20),
                    child: Text(
                      "Elige tu tipo de usuario para comenzar a utilizar la aplicación",
                      style: kHeading4,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            // Paciente
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: AssetImage('assets/logos/google_logo.png'),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: styleBlackButton,
                    onPressed: () {
                      loginPatient(context);
                    },
                    child: const Text('SOY PACIENTE', style: kHeading4),
                  ),
                ],
              ),
            ),
            //Nutricionisa
            Container(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: AssetImage('assets/logos/google_logo.png'),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: styleBlackButton,
                    onPressed: () {
                      loginNutritionist(context);
                    },
                    child: const Text('SOY NUTRICIONISTA', style: kHeading4),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void loginPatient(BuildContext context) {
  PatientService _patientService = PatientService();
  _patientService.signInWithGoogle(context);
}

void loginNutritionist(BuildContext context) {
  NutritionistService _nutritionistService = NutritionistService();
  _nutritionistService.signInWithGoogle(context);
}
