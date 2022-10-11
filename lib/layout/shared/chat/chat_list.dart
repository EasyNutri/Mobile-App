// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable, unused_field, prefer_final_fields

import 'package:easy_nutrition/data/user.dart';
import 'package:easy_nutrition/layout/shared/chat/chat_page.dart';
import 'package:easy_nutrition/services/nutritionist_services.dart';
import 'package:easy_nutrition/services/patient_services.dart';
import 'package:easy_nutrition/services/user_service.dart';
import 'package:easy_nutrition/utilities/designs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  String _textSearch = "";

  final _currentUser = FirebaseAuth.instance.currentUser!;
  PatientService _patientService = PatientService();
  NutritionistService _nutritionistService = NutritionistService();
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            //! Seach
            buildSearchBar(),
            //! Lista
            Expanded(child: buildListChat()),
            //! Button
            buildContactButton()
          ],
        ),
      ),
    );
  }

  Widget buildListChat() {
    return FutureBuilder<List<MyUser>>(
      future: _userService.getAllUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.isEmpty) {
          return const Center(child: Text("No se encontraron usuarios"));
        }

        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: ((context, index) =>
                buildItemChat(context, index, snapshot)));
      },
    );
  }

  Widget buildItemChat(
      BuildContext context, int index, AsyncSnapshot snapshot) {
    MyUser myUser = snapshot.data![index];
    if (myUser.name.toLowerCase().contains(_textSearch.toLowerCase())) {
      return Container(
        margin: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
        child: TextButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute<void>(builder: (BuildContext context) {
              return ChatPage(
                  anotherUserId: myUser.id,
                  anotherUserName: myUser.name,
                  anotherUserPhotoUrl: myUser.photoUrl);
            }));
          },
          style: styleChatItem,
          child: Row(
            children: <Widget>[
              //! Foto
              Material(
                child: myUser.photoUrl.isNotEmpty
                    ? Image.network(
                        myUser.photoUrl,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: myGreenColor,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, object, stackTrace) {
                          return const Icon(
                            Icons.account_circle,
                            size: 50,
                            color: myGreyColor,
                          );
                        },
                      )
                    : const Icon(
                        Icons.account_circle,
                        size: 50,
                        color: myGreyColor,
                      ),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                clipBehavior: Clip.hardEdge,
              ),
              //! Nombre
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          myUser.name,
                          maxLines: 1,
                          style: const TextStyle(
                              color: myGreenColor, fontSize: 20),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(left: 20),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildSearchBar() {
    return Container(
      height: 40,
      child: Row(
        children: [
          Icon(Icons.search, color: myBlackColor, size: 20),
          SizedBox(width: 5),
          Expanded(
            child: TextField(
              onChanged: (value) {
                setState(
                  () {
                    _textSearch = value;
                  },
                );
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Buscar usuario',
                hintStyle: TextStyle(fontSize: 13, color: myBlackColor),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: myGreyColor,
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(30),
    );
  }

  Widget buildContactButton() {
    return Container(
      margin: EdgeInsets.all(30),
      child: ElevatedButton(
        onPressed: () {},
        child: Text("Quiero contactar un nutricionista"),
        style: styleGreenLargeButton,
      ),
    );
  }
}
