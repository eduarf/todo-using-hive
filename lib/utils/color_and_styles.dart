import 'package:flutter/material.dart';

const colorRed = Color(0xFFF24C0D);
const colorGreen = Color(0xFF5FC410);
const colorGold = Color.fromARGB(255, 251, 255, 22);
const colorWhite = Color(0xFFFEFFF6);
const colorBlack = Color(0xFF000000);


const TextStyle styleBold = TextStyle(
  color: colorGold,
  fontWeight: FontWeight.w800,
  fontSize: 20,
  letterSpacing: 1,
);

const TextStyle styleTask = TextStyle(
  color: colorWhite,
  fontWeight: FontWeight.w600,
  fontSize: 16,
  letterSpacing: 1,
);

class Paddings {
  static const paddingLeft = EdgeInsets.only(left: 10);
}