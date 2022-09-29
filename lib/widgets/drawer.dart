// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:easy_nutrition/services/patient_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    // if(user.type == paciente)
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user.displayName!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(user.email!),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
            ),
          ),
          ListTile(
            title: Text('Perfil'),
            leading: Icon(Icons.account_circle),
            onTap: () {},
          ),
          ListTile(
            title: Text('Mi Nutricionista'),
            leading: Icon(Icons.medical_information),
            onTap: () {},
          ),
          ListTile(
            title: Text('Configuración'),
            leading: Icon(Icons.settings),
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(color: Colors.black),
          ),
          ListTile(
            title: Text('Cerrar Sesión'),
            leading: Icon(Icons.logout),
            onTap: () {
              logOut(context);
            },
          )
        ],
      ),
    );
    //else
  }
}

void logOut(BuildContext context) {
  PatientService _patientServices = PatientService();
  _patientServices.signOutPatient(context);
}
