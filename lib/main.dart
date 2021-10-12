import 'package:flutter/material.dart';
import 'package:shop2/bloc_observer.dart';
import 'package:shop2/src/UI/theme/theme.dart';
import 'package:shop2/src/config/end_points.dart';
import 'package:shop2/src/core/route/routes.dart';
import 'package:shop2/src/cubit/home_screen_cubit/cubit.dart';
import 'package:shop2/src/cubit/home_screen_cubit/state.dart';
import 'package:shop2/src/data/local/cache_helper.dart';
import 'package:shop2/src/data/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  //check if is first && if is login

  bool isFirst = CacheHelper.getData(key: 'isFirst') ?? false;
  token = CacheHelper.getData(key: 'token') ?? '';
  String? initRoute;
  if (isFirst) {
    if (token!.isNotEmpty) {
      initRoute = '/home';
    } else {
      initRoute = '/login';
    }
  } else {
    initRoute = '/';
  }

  runApp(MyApp(initRoute: initRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.initRoute}) : super(key: key);
  final String? initRoute;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopCubit>(
          create: (BuildContext context) => ShopCubit(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, index) {},
        builder: (context, index) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Training',
            theme: lightThemeData,
            darkTheme: darkThemeData,
            themeMode: ThemeMode.system,
            initialRoute: initRoute,
            onGenerateRoute: AppRoute.generateRoutes,
          );
        },
      ),
    );
  }
}
