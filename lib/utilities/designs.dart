import 'package:flutter/material.dart';

const Color kmainColor1 = Color(0xFF86DD75);

const Color kmainColor2 = Color(0xFF37B51F);

const Color kmainColor3 = Color(0xFF47FF86);



const kHeading1 = TextStyle(
  fontFamily: 'rbold',
  fontSize: 48,
);

const kHeading2 = TextStyle(
  fontFamily: 'rbold',
  fontSize: 40,
);

const kHeading3 = TextStyle(
  fontFamily: 'rlight',
  fontSize: 32,
);

const kHeading4 = TextStyle(
  fontFamily: 'rlight',
  fontSize: 20,
);

const kHeading5 = TextStyle(
  fontFamily: 'rbold',
  fontSize: 15,
);

ButtonStyle styleBlackButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  fixedSize: MaterialStateProperty.all(const Size(250.0, 46.0)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);

ButtonStyle styleButton1 = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(kmainColor2),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  fixedSize: MaterialStateProperty.all(const Size(160.0, 46.0)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);

ButtonStyle styleButton2 = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(kmainColor1),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  fixedSize: MaterialStateProperty.all(const Size(250.0, 46.0)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);
