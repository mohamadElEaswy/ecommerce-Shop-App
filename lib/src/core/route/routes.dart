import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop2/src/UI/screens/home/home_screen.dart';
import 'package:shop2/src/UI/screens/home/product_details/product_details.dart';
import 'package:shop2/src/UI/screens/login/login_screen.dart';
import 'package:shop2/src/UI/screens/on_boarding/on_boarding_screen.dart';
import 'package:shop2/src/UI/screens/register/register_screen.dart';
import 'package:shop2/src/config/end_points.dart';

class AppRoute {
  static Route<dynamic> generateRoutes(
    RouteSettings settings,
  ) {
    final args = settings.arguments;

    // if (!isFirst!) {
    //   return MaterialPageRoute(
    //     builder: (context) => const OnBoardingScreen(),
    //   );
    // } else if (isFirst!) {
    //   return MaterialPageRoute(
    //     builder: (context) => const LogInScreen(),
    //   );
    // }else if (settings.name == LogInScreen.routeName) {
    //   return MaterialPageRoute(
    //     builder: (context) => const LogInScreen(),
    //   );
    // } else if (settings.name == RegisterScreen.routeName) {
    //   return MaterialPageRoute(
    //     builder: (context) => const RegisterScreen(),
    //   );
    // } else if (settings.name == HomeScreen.routeName && token!.isNotEmpty) {
    //   return MaterialPageRoute(
    //     builder: (context) => const HomeScreen(),
    //   );
    // }else if (token!.isNotEmpty) {
    //   return MaterialPageRoute(
    //     builder: (context) => const HomeScreen(),
    //   );
    // } else {
    //   return _errorRoute();
    // }

    switch (settings.name) {
      case OnBoardingScreen.routeName:
        if (!isFirst! && token!.isEmpty) {
          return MaterialPageRoute(
            builder: (context) => const OnBoardingScreen(),
          );
        } else {
          return _errorRoute();
        }

      case LogInScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const LogInScreen(),
        );

      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );

      case HomeScreen.routeName:
        if (token!.isNotEmpty) {
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const LogInScreen(),
          );
        }

      case ProductDetails.routeName:
        if(args != null){
          return MaterialPageRoute(
            builder: (context) => ProductDetails(
              productId: args,
            ),
          );
        }else{ return _errorRoute();}

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
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
