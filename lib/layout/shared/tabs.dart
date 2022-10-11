// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, dead_code, avoid_print, prefer_interpolation_to_compose_strings

import 'package:easy_nutrition/layout/nutritionist/appointment/nutritionist_appointment.dart';
import 'package:easy_nutrition/layout/nutritionist/home/nutritionist_home.dart';
import 'package:easy_nutrition/services/user_service.dart';
import 'package:easy_nutrition/widgets/widgets.dart';

import 'package:easy_nutrition/layout/patient/home/patient_home.dart';
import 'package:easy_nutrition/layout/patient/appointment/patient_appointment.dart';
import 'package:easy_nutrition/layout/shared/chat/chat_list.dart';
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
    ChatList(),
    SettingsPage()
  ];

  final List<Widget> _nutritionTabs = [
    NutritionistHome(),
    NutritionistAppointment(),
    ChatList(),
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
      backgroundColor: myWhiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: myBlackColor,
        backgroundColor: myWhiteColor,
        title: MyAppBarTitle(context: context),
      ),
      body: MyBodyApp(user.uid, context),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: myBlackColor,
            ),
            label: 'Inicio',
            backgroundColor: myGreenColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              color: myBlackColor,
            ),
            label: 'Reserva',
            backgroundColor: myGreenColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: myBlackColor,
            ),
            label: 'Chat',
            backgroundColor: myGreenColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: myBlackColor,
            ),
            label: 'Ajustes',
            backgroundColor: myGreenColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: myBlackColor,
        onTap: _onItemTapped,
        iconSize: 45.0,
      ),
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
}
