// ignore_for_file: prefer_const_constructors

import 'package:easy_nutrition/services/nutritionist_services.dart';
import 'package:easy_nutrition/utilities/designs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NutritionistRegister extends StatefulWidget {
  const NutritionistRegister({super.key});

  @override
  State<NutritionistRegister> createState() => _NutritionistRegisterState();
}

class _NutritionistRegisterState extends State<NutritionistRegister> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _keyForm = GlobalKey<FormState>();
    final user = FirebaseAuth.instance.currentUser!;

    firstNameController.text = user.displayName!;
    emailController.text = user.email!;

    return Scaffold(
        appBar: AppBar(
          title: Text("Registro Nutricionista"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _keyForm,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Text("Registro de datos"),
                    Text("Registre sus datos para conocerlo mejor"),
                    InputTextWidget(
                      //! Nombre
                      Controller: firstNameController,
                      Formatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                      ],
                      Label: 'Nombres',
                      inputType: TextInputType.text,
                      Validator: (value) {
                        return ValidateText("Nombre", value!);
                      },
                      Enabled: true,
                    ),
                    InputTextWidget(
                      //! Nombre
                      Controller: lastNameController,
                      Formatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                      ],
                      Label: 'Apellidos',
                      inputType: TextInputType.text,
                      Validator: (value) {
                        return ValidateText("Apellido", value!);
                      },
                      Enabled: true,
                    ),
                    InputTextWidget(
                      //! Correo
                      Controller: emailController,
                      Formatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                      ],
                      Label: 'Correo',
                      inputType: TextInputType.emailAddress,
                      Enabled: false,
                    ),
                    InputTextWidget(
                      //! Celular
                      Controller: phoneNumberController,
                      Formatters: [FilteringTextInputFormatter.digitsOnly],
                      Label: 'Celular',
                      inputType: TextInputType.number,
                      Validator: (value) {
                        return ValidatePhoneNumber(value!);
                      },
                      Enabled: true,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          style: styleButton1,
                          onPressed: () => {
                            insertDataNutritionist(
                                user.uid,
                                firstNameController.text,
                                lastNameController.text,
                                emailController.text,
                                phoneNumberController.text,
                                user.photoURL!,
                                context),
                          },
                          child: const Text('SIGUIENTE', style: kHeading5),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}

class InputTextWidget extends StatelessWidget {
  InputTextWidget({
    required this.Controller,
    required this.Formatters,
    required this.Label,
    required this.inputType,
    this.Validator,
    required this.Enabled,
  });

  final TextEditingController Controller;
  final TextInputType inputType;
  final List<TextInputFormatter> Formatters;
  final String Label;
  final FormFieldValidator<String>? Validator;
  final bool Enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(fontSize: 13.0),
        enabled: Enabled,
        controller: Controller,
        keyboardType: inputType,
        inputFormatters: Formatters,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          border: OutlineInputBorder(),
          labelText: Label,
          labelStyle: kHeading5,
        ),
        validator: Validator,
      ),
    );
  }
}

String? ValidateText(String label, String value) {
  if (value.isEmpty) {
    return '${label} es obligatorio';
  }
  if (value.length < 3) {
    return '${label} debe tener mínimo 3 carácteres';
  }
  return null;
}

String? ValidatePhoneNumber(String value) {
  if (value.isEmpty) {
    return 'Celular es obligatorio';
  }
  if (value[0] != '9') {
    return 'Celular debe comenzar con 9';
  }
  if (value.length != 9) {
    return 'Celular debe tener 9 dígitos';
  }
  return null;
}

void insertDataNutritionist(String id, String firstName, String lastName,
    String email, String phoneNumber, String photoUrl, BuildContext context) {
  NutritionistService _nutritionistService = NutritionistService();

  _nutritionistService.createNutritionist(
      id, firstName, lastName, email, phoneNumber, photoUrl, context);
}
