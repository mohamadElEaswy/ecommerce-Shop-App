import 'package:flutter/material.dart';
import 'package:shop2/src/config/end_points.dart';
import 'package:shop2/src/core/models/user_model.dart';
import 'package:shop2/src/core/route/const_route_functions.dart';
import 'package:shop2/src/cubit/auth_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop2/src/data/local/cache_helper.dart';
import 'package:shop2/src/data/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(InitialShopState());
  static ShopCubit get(context) => BlocProvider.of(context);

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
    }, ).then((value) {
      emit(RegisterLoadingState());
      userModel = UserModel.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: userModel.userData!.token);
      token = CacheHelper.getData(key: 'token');
      navigateAndRemove(
        context: context,
        newRouteName: '/home',
      );
      emit(RegisterSuccessState());
    }).catchError((e) {
      RegisterErrorState(e);
    });
  }
}
