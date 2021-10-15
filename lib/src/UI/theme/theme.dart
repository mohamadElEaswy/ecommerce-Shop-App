import 'package:flutter/material.dart';

// initialize light theme data
ThemeData lightThemeData = ThemeData(
  // textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white)),
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
    ),
  ),
  //appBar theme data style
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    centerTitle: true,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  //bottom navigation bar theme data styke
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    unselectedItemColor: Colors.black54,
    selectedItemColor: Colors.black,
  ),
);

// initialize dark theme data
ThemeData darkThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white10,
    centerTitle: true,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black54,
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    unselectedItemColor: Colors.white30,
    selectedItemColor: Colors.white,
  ),
);
