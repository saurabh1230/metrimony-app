import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  scaffoldBackgroundColor: const Color(0xffFFFFFF),
  useMaterial3: false,
  fontFamily: 'Nunito Sans',
  primaryColor: const Color(0xfff9436b),
  // primaryColor: const Color(0xffa4aca4),
  primaryColorDark: Colors.black,
  secondaryHeaderColor: const Color(0xFF0e8fd2),
  highlightColor: Color(0xff0b1023),
  disabledColor: const Color(0xFFA0A4A8),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xfff9436b))), colorScheme: const ColorScheme.light(primary: Color(0xfff9436b), secondary: Color(0xfff9436b)).copyWith(error: const Color(0xfff9436b)),
);


// const Color primaryColor = Color(0xfff9436b);
const Color themeRedColor = Colors.redAccent;
const Color primaryColor = Color(0xffa4aca4);
const Color casteIconColor = Color(0xff7d8f9b);
const Color darkBlueColor = Color(0xff0b1023);
