import 'package:assignment/constant/colors.dart';
import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
    primaryTextTheme: const TextTheme(
      headline5: TextStyle(
        fontFamily: 'Akira',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontFamily: 'Avenir',
        fontSize: 14,
        color: Colors.black,
      ),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: darkBlue),
    primaryColor: yellow,
    scaffoldBackgroundColor: Colors.white,
    cardColor: blue,
    dividerColor: lightBlue,
    focusColor: yellow,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: darkBlue,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: orange,
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: orange,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: orange,
        elevation: 5
    ), colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(0xFFFFB703, color)).copyWith(secondary: orange)
);