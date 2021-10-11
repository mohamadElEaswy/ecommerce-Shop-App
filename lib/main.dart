import 'package:flutter/material.dart';
import 'package:shop2/src/UI/theme/theme.dart';
import 'package:shop2/src/core/route/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Training',
      theme: lightThemeData,
      initialRoute: '/',
      onGenerateRoute: AppRoute.generateRoutes,
    );
  }
}



