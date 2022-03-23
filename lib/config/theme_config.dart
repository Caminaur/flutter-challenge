import 'package:flutter/material.dart';

ThemeData theme() {
  const mainColor = Color.fromRGBO(255, 232, 31, 1);
  return ThemeData.dark().copyWith(
    dividerColor: mainColor,
    primaryColor: mainColor,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme().copyWith(
      foregroundColor: Colors.black,
      backgroundColor: mainColor,
    ),
    drawerTheme: const DrawerThemeData().copyWith(
      // scrimColor: Colors.black,
      backgroundColor: Colors.black,
    ),
    textTheme: const TextTheme().copyWith(
      headline1: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: mainColor,
      ),
      headline2: const TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        color: mainColor,
      ),
      headline3: const TextStyle(
        fontSize: 23.0,
        fontWeight: FontWeight.bold,
        color: mainColor,
      ),
      headline4: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: mainColor,
      ),
      headline5: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: mainColor,
      ),
      headline6: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: mainColor,
      ),
    ),
  );
}
