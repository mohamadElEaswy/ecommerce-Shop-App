import 'package:shop2/src/core/models/categories_model.dart';
import 'package:shop2/src/core/models/favourites_model.dart';
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



class CategoriesLoadingState extends HomeState {}

class CategoriesSuccessState extends HomeState {
  final CategoriesModel? categoriesModel;

  CategoriesSuccessState({required this.categoriesModel});
}

class CategoriesErrorState extends HomeState {
  final String error;

  CategoriesErrorState({required this.error});
}

class ChangeLoadingSuccessState extends HomeState {}

class ChangeFavoriteSuccessState extends HomeState {
  final ChangeFavouritesModel? changeFavouritesModel;

  ChangeFavoriteSuccessState({required this.changeFavouritesModel});
}

class ChangeFavoritesErrorState extends HomeState {
  final String error;

  ChangeFavoritesErrorState({required this.error});
}


class GetFavoritesLoadingState extends HomeState{}
class FavoritesSuccessState extends HomeState{
  final FavouriteModel? favouriteModel;

  FavoritesSuccessState({required this.favouriteModel});
}
class FavoritesErrorState extends HomeState{
  final String error;

  FavoritesErrorState({required this.error});
}
