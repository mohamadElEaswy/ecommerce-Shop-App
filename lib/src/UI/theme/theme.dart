import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
    ),
  ),
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
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    unselectedItemColor: Colors.black54,selectedItemColor: Colors.black,
  ),
);
ThemeData darkThemeData= ThemeData(

);