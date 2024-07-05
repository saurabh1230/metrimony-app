import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  scaffoldBackgroundColor: const Color(0xffFFFFFF),
  useMaterial3: false,
  fontFamily: 'Nunito Sans',
  primaryColor: const Color(0xfff9436b),
  primaryColorDark: Colors.black,
  secondaryHeaderColor: const Color(0xFF1E6EB3),
  disabledColor: const Color(0xFFA0A4A8),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xfff9436b))), colorScheme: const ColorScheme.light(primary: Color(0xfff9436b), secondary: Color(0xfff9436b)).copyWith(error: const Color(0xfff9436b)),
);


const Color primaryColor = Color(0xfff9436b);
