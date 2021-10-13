import 'package:shop2/src/core/models/home_model.dart';
import 'package:shop2/src/core/models/user_model.dart';

abstract class ShopState {}

class InitialShopState extends ShopState {}

class LoadingShopState extends ShopState {}

class LoginShopState extends ShopState {}

class LoginErrorShopState extends ShopState {
  final String error;

  LoginErrorShopState(this.error);
}

class ChangeBottomNavigationState extends ShopState {}

class ChangePasswordVisibilityState extends ShopState {}

class LoginLoadingState extends ShopState {}

class LoginSuccessState extends ShopState {
  final UserModel userModel;

  LoginSuccessState(this.userModel);
}

class LoginErrorState extends ShopState {
  final String error;

  LoginErrorState(this.error);
}

class RegisterLoadingState extends ShopState {}

class RegisterSuccessState extends ShopState {
  final UserModel userModel;

  RegisterSuccessState(this.userModel);
}

class RegisterErrorState extends ShopState {
  final String error;

  RegisterErrorState(this.error);
}

class HomeDataLoadingState extends ShopState {}

class HomeDataSuccessState extends ShopState {
  final HomeModel homeModel;

  HomeDataSuccessState(this.homeModel);
}

class HomeDataErrorState extends ShopState {
  final String error;

  HomeDataErrorState(this.error);
}


class UpdateLoadingState extends ShopState {}

class UpdateSuccessState extends ShopState {
  final UserModel userModel;

  UpdateSuccessState(this.userModel);
}

class UpdateErrorState extends ShopState {
  final String error;

  UpdateErrorState(this.error);


}


class SettingsLoadingState extends ShopState {}

class SettingsSuccessState extends ShopState {
  final UserModel userModel;

  SettingsSuccessState(this.userModel);
}

class SettingsErrorState extends ShopState {
  final String error;

  SettingsErrorState(this.error);
}

