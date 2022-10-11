import 'package:flutter/material.dart';

const Color myGreenColor = Color(0xFF2BB54E);
const Color myGreyColor = Color(0xFFE0E0E0);
const Color myBlackColor = Colors.black;
const Color myWhiteColor = Colors.white;

const myHeading1 = TextStyle(
  fontFamily: 'rbold',
  fontSize: 48,
);

const myHeading2 = TextStyle(
  fontFamily: 'rbold',
  fontSize: 40,
);

const myHeading3 = TextStyle(
  fontFamily: 'rlight',
  fontSize: 32,
);

const myHeading4 = TextStyle(
  fontFamily: 'rlight',
  fontSize: 20,
);

const myHeading5 = TextStyle(
  fontFamily: 'rbold',
  fontSize: 15,
);

ButtonStyle styleBlackButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(myBlackColor),
  foregroundColor: MaterialStateProperty.all<Color>(myWhiteColor),
  fixedSize: MaterialStateProperty.all(const Size(290, 46)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);

ButtonStyle styleChatItem = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(myBlackColor),
  backgroundColor: MaterialStateProperty.all<Color>(myWhiteColor),
  shape: MaterialStateProperty.all<OutlinedBorder>(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
);

ButtonStyle styleGreenLargeButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(myGreenColor),
  foregroundColor: MaterialStateProperty.all<Color>(myWhiteColor),
  fixedSize: MaterialStateProperty.all(const Size(290, 46)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);

ButtonStyle styleButton2 = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(myGreenColor),
  foregroundColor: MaterialStateProperty.all<Color>(myWhiteColor),
  fixedSize: MaterialStateProperty.all(const Size(250.0, 46.0)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);
