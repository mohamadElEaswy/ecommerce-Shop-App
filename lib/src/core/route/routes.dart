import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop2/src/UI/screens/home/home_screen.dart';
import 'package:shop2/src/UI/screens/login/login_screen.dart';
import 'package:shop2/src/UI/screens/on_boarding/on_boarding_screen.dart';
import 'package:shop2/src/UI/screens/register/register_screen.dart';


class AppRoute {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );

        case '/login':
        return MaterialPageRoute(
          builder: (context) => const LogInScreen(),
        );

        case '/register':
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );

        case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}


//default error screen
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('an Error happened while you are navigating in the app '),
      ),
    );
  }
}
