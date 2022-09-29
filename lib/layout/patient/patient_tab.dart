// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_nutrition/layout/patient/home/patient_home.dart';
import 'package:easy_nutrition/layout/patient/appointment/patient_appointment.dart';
import 'package:easy_nutrition/layout/shared/chat_page.dart';
import 'package:easy_nutrition/layout/shared/settings_page.dart';
import 'package:easy_nutrition/utilities/designs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientTabs extends StatefulWidget {
  const PatientTabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<PatientTabs> {
  int _selectedIndex = 0;
  var user = FirebaseAuth.instance.currentUser!;

  final List<Widget> _tabs = [
    PatientHome(),
    PatientAppointment(),
    ChatPage(),
    SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hola, ${user.displayName}",
                    style: kHeading4,
                  ),
                  Text(
                    "Paciente | Plan Free",
                    style: kHeading5,
                  )
                ],
              ),
            ),
            Spacer(),
            Icon(Icons.notifications_none_outlined)
          ],
        ),
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            label: 'Inicio',
            backgroundColor: colorPrincipal3,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              color: Colors.black,
            ),
            label: 'Reserva',
            backgroundColor: colorPrincipal3,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Colors.black,
            ),
            label: 'Chat',
            backgroundColor: colorPrincipal3,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            label: 'Ajustes',
            backgroundColor: colorPrincipal3,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        iconSize: 45.0,
      ),
    );
  }
}
