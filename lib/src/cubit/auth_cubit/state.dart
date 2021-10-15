import 'package:shop2/src/core/models/user_model.dart';

//before login states
//auth states login, register , re open the app after login or register
abstract class ShopState {}

class InitialShopState extends ShopState {}

//login states
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
//register states

class RegisterLoadingState extends ShopState {}

class RegisterSuccessState extends ShopState {}

class RegisterErrorState extends ShopState {
  final String error;

  RegisterErrorState(this.error);
}
