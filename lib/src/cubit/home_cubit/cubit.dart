import 'package:flutter/material.dart';
import 'package:shop2/src/UI/screens/home/cart/cart.dart';
import 'package:shop2/src/UI/screens/home/favorite/favorite.dart';
import 'package:shop2/src/UI/screens/home/home_screen.dart';
import 'package:shop2/src/UI/screens/home/setting/setting.dart';
import 'package:shop2/src/cubit/home_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());
  static HomeCubit get(context) => BlocProvider.of(context);

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
}
