import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black),)),
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
  // elevatedButtonTheme: const ElevatedButtonThemeData(
  //   style: ButtonStyle(backgroundColor: MaterialStatePropertyColor<Color?>),
  // ),
);
