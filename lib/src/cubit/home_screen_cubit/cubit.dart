import 'package:flutter/material.dart';
import 'package:shop2/src/UI/screens/home/cart/cart.dart';
import 'package:shop2/src/UI/screens/home/favorite/favorite.dart';
import 'package:shop2/src/UI/screens/home/home_screen.dart';
import 'package:shop2/src/UI/screens/home/setting/setting.dart';
import 'package:shop2/src/config/end_points.dart';
import 'package:shop2/src/core/models/home_model.dart';
import 'package:shop2/src/core/models/user_model.dart';
import 'package:shop2/src/core/route/const_route_functions.dart';
import 'package:shop2/src/cubit/home_screen_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop2/src/data/local/cache_helper.dart';
import 'package:shop2/src/data/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(InitialShopState());
  static ShopCubit get(context) => BlocProvider.of(context);
/*manage bottom navigation bar*/
  int currentIndex = 0;
  List<Widget> body = [
    const Home(),
    const CartScreen(),
    const FavoriteScreen(),
    const SettingScreen(),
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'cart',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'favorite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'setting',
    ),
  ];

  void changeScreen({required int index}) {
    currentIndex = index;
    emit(ChangeBottomNavigationState());
  }

  //end bottom navigation bar
  //password visibility!!?
  bool isPassword = true;
  IconData passwordIcon = Icons.visibility;

  void changePassword() {
    isPassword != isPassword;
    isPassword
        ? passwordIcon = Icons.visibility_off
        : passwordIcon = Icons.visibility;
    emit(ChangePasswordVisibilityState());
  }

  //login methods
  late UserModel userModel;
  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(LoginLoadingState());
    DioHelper.post(url: login, data: {'email': email, 'password': password})
        .then((value) {
      userModel = UserModel.fromJson(value.data);
      //save token to shared preference
      CacheHelper.saveData(key: 'token', value: userModel.userData!.token);
      //save token into variable to use it
      token = userModel.userData!.token;
      navigateAndRemove(
        context: context,
        newRouteName: '/home',
      );
      emit(LoginSuccessState(userModel));
    }).catchError((e) {
      // ignore: avoid_print
      emit(LoginErrorState(e.toString()));
    });
  }
  //end login methods

  //register methods
  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
    required BuildContext context,
  }) {
    DioHelper.post(url: register, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }).then((value) {
      emit(RegisterLoadingState());
      userModel = UserModel.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: userModel.userData!.token);
      token = CacheHelper.getData(key: 'token');
      navigateAndRemove(
        context: context,
        newRouteName: '/home',
      );
      emit(RegisterSuccessState(userModel));
    }).catchError((e) {
      RegisterErrorState(e.toString());
    });
  }

  HomeModel? homeModel;
  void getHomeData() {
    DioHelper.get(url: home, token: token).then((value) {
      emit(HomeDataLoadingState());
      homeModel = HomeModel.fromJson(value.data);

      emit(HomeDataSuccessState(homeModel!));
    }).catchError((e) {
      emit(HomeDataErrorState(e.toString()));
    });
  }




  //get user data (SETTINGS DATA)
  void getSettings() {
    DioHelper.get(url: profile, token: token).then((value) {
      emit(SettingsLoadingState());
      userModel = UserModel.fromJson(value.data);
      emit(SettingsSuccessState(userModel));
    }).catchError((e) {
      emit(SettingsErrorState(e.toString()));
    });
  }

//edit user data ((SETTINGS))
  void userUpdate({
    required String email,
    // required String password,
    required String phone,
    required String name,
    required BuildContext context,
  }) {
    DioHelper.put(url: update, token: token, data: {
      'email': email,
      // 'password': password,
      'name': name,
      'phone': phone,
    }).then((value) {
      emit(UpdateLoadingState());
      userModel = UserModel.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: userModel.userData!.token);
      token = CacheHelper.getData(key: 'token');
      navigateAndRemove(
        context: context,
        newRouteName: '/home',
      );
      emit(UpdateSuccessState(userModel));
    }).catchError((e) {
      UpdateErrorState(e.toString());
    });
  }

}
