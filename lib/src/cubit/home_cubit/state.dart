import 'package:shop2/src/core/models/home_model.dart';
import 'package:shop2/src/core/models/user_model.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final HomeModel? homeModel;

  HomeSuccessState({required this.homeModel});
}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
}

class ChangeBottomNavigationState extends HomeState {}

class ChangePasswordVisibilityState extends HomeState {}

class SettingsLoadingState extends HomeState {}

class SettingsSuccessState extends HomeState {
  final UserModel? userModel;

  SettingsSuccessState({required this.userModel});
}

class SettingsErrorState extends HomeState {
  final String error;

  SettingsErrorState({required this.error});
}

class UpdateLoadingState extends HomeState {}

class UpdateSuccessState extends HomeState {
  final UserModel? userModel;

  UpdateSuccessState({required this.userModel});
}

class UpdateErrorState extends HomeState {
  final String error;

  UpdateErrorState({required this.error});
}
