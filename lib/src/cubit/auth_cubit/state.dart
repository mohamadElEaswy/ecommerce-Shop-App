import 'package:shop2/src/core/models/user_model.dart';

abstract class ShopState {}

class InitialShopState extends ShopState {}

class LoadingShopState extends ShopState {}

class LoginShopState extends ShopState {}

class LoginErrorShopState extends ShopState {
  final String error;

  LoginErrorShopState(this.error);
}

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

class RegisterSuccessState extends ShopState {}

class RegisterErrorState extends ShopState {
  final String error;

  RegisterErrorState(this.error);
}

class HomeDataLoadingState extends ShopState {}

class HomeDataSuccessState extends ShopState {}

class HomeDataErrorState extends ShopState {
  final String error;

  HomeDataErrorState(this.error);
}
