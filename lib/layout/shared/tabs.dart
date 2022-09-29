// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, dead_code, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:easy_nutrition/layout/nutritionist/appointment/nutritionist_appointment.dart';
import 'package:easy_nutrition/layout/nutritionist/home/nutritionist_home.dart';
import 'package:easy_nutrition/services/user_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:easy_nutrition/layout/patient/home/patient_home.dart';
import 'package:easy_nutrition/layout/patient/appointment/patient_appointment.dart';
import 'package:easy_nutrition/layout/shared/chat_page.dart';
import 'package:easy_nutrition/layout/shared/settings_page.dart';
import 'package:easy_nutrition/utilities/designs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;
  var user = FirebaseAuth.instance.currentUser!;
  final UserService _userService = UserService();

  final List<Widget> _patientTabs = [
    PatientHome(),
    PatientAppointment(),
    ChatPage(),
    SettingsPage()
  ];

  final List<Widget> _nutritionTabs = [
    NutritionistHome(),
    NutritionistAppointment(),
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
    if (kIsWeb) {
      return WebTab(context);
    } else {
      return AndroidTab(context);
    }
  }

  Widget AndroidTab(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: MyTitleApp(user.uid, context),
      ),
      body: MyBodyApp(user.uid, context),
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

  Widget WebTab(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: MyTitleApp(user.uid, context),
        ),
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: TextStyle(color: Colors.green),
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                  ),
                  selectedIcon: Icon(
                    Icons.home_outlined,
                    color: colorPrincipal1,
                  ),
                  label: Text('Inicio'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Colors.black,
                  ),
                  selectedIcon: Icon(
                    Icons.calendar_month,
                    color: colorPrincipal1,
                  ),
                  label: Text('Reserva'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.chat,
                    color: Colors.black,
                  ),
                  selectedIcon: Icon(
                    Icons.chat,
                    color: colorPrincipal1,
                  ),
                  label: Text('Chat'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  selectedIcon: Icon(
                    Icons.settings,
                    color: colorPrincipal1,
                  ),
                  label: Text('Ajustes'),
                )
              ],
            ),
            const VerticalDivider(
              thickness: 1,
              width: 1,
            ),
            Expanded(child: MyBodyApp(user.uid, context))
          ],
        ));
  }

  Widget MyTitleApp(String uid, BuildContext context) {
    return FutureBuilder(
      future: _userService.getUser(uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          Text("Cargando");
        }
        var myUser = snapshot.data;
        var userType = myUser!.userType;
        if (userType == "patient") {
          return PatientTitle(context);
        }
        if (userType == 'nutritionist') {
          return NutritionTitle(context);
        }
        return Center(child: Text("Falla en la carga"));

        print(userType);
      },
    );
  }

  Widget MyBodyApp(String uid, BuildContext context) {
    return FutureBuilder(
      future: _userService.getUser(uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          Text("Cargando");
        }
        var myUser = snapshot.data;
        var userType = myUser!.userType;
        if (userType == "patient") {
          return _patientTabs[_selectedIndex];
        }
        if (userType == 'nutritionist') {
          return _nutritionTabs[_selectedIndex];
        }
        return Center(child: Text("Falla en la carga"));

        print(userType);
      },
    );
  }

  Widget PatientTitle(BuildContext context) {
    return Row(
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
    );
  }

  Widget NutritionTitle(BuildContext context) {
    return Row(
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
                "Nutricionista",
                style: kHeading5,
              )
            ],
          ),
        ),
        Spacer(),
        Icon(Icons.notifications_none_outlined)
      ],
    );
  }
}
