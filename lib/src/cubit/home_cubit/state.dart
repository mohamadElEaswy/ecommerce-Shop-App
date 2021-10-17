import 'package:shop2/src/core/models/cart_model.dart';
import 'package:shop2/src/core/models/categories_model.dart';
import 'package:shop2/src/core/models/favourites_model.dart';
import 'package:shop2/src/core/models/home_model.dart';
import 'package:shop2/src/core/models/user_model.dart';
//after login states

abstract class HomeState {}

//Pagination states
class HomeInitState extends HomeState {}

//new data state
class HomeLoadingState extends HomeState {
  final HomeModel? homeModel;

  HomeLoadingState({required this.homeModel});
}

//old data state
class HomeSuccessState extends HomeState {
  final HomeModel? homeModel;

  HomeSuccessState({required this.homeModel});
}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
}
//end pagination states

//bottom navigation bar state
class ChangeBottomNavigationState extends HomeState {}

//password field visibility state
class ChangePasswordVisibilityState extends HomeState {}

//get setting states
class SettingsLoadingState extends HomeState {}

class SettingsSuccessState extends HomeState {
  final UserModel? userModel;

  SettingsSuccessState({required this.userModel});
}

class SettingsErrorState extends HomeState {
  final String error;

  SettingsErrorState({required this.error});
}

//settings after editing states
class UpdateLoadingState extends HomeState {}

class UpdateSuccessState extends HomeState {
  final UserModel? userModel;

  UpdateSuccessState({required this.userModel});
}

class UpdateErrorState extends HomeState {
  final String error;

  UpdateErrorState({required this.error});
}
//end settings states

//categories staes
class CategoriesLoadingState extends HomeState {}

class CategoriesSuccessState extends HomeState {
  final CategoriesModel? categoriesModel;

  CategoriesSuccessState({required this.categoriesModel});
}

class CategoriesErrorState extends HomeState {
  final String error;

  CategoriesErrorState({required this.error});
}
//end categories states

//change favourites states
class ChangeLoadingSuccessState extends HomeState {}

class CategoriesDetailsLoadingState extends HomeState {}

class CategoriesDetailsSuccessState extends HomeState {
  final CategoriesModel? categoriesModel;

  CategoriesDetailsSuccessState({required this.categoriesModel});
}

class CategoriesDetailsErrorState extends HomeState {
  final String error;

  CategoriesDetailsErrorState({required this.error});
}
//end categories states

//change favourites states
// class ChangeLoadingSuccessState extends HomeState {}

class ChangeFavoriteSuccessState extends HomeState {
  final ChangeFavouritesModel? changeFavouritesModel;

  ChangeFavoriteSuccessState({required this.changeFavouritesModel});
}

class ChangeFavoritesErrorState extends HomeState {
  final String error;

  ChangeFavoritesErrorState({required this.error});
}

//get favourites data states
class GetFavoritesLoadingState extends HomeState {}

class FavoritesSuccessState extends HomeState {
  final FavouriteModel? favouriteModel;

  FavoritesSuccessState({required this.favouriteModel});
}

class FavoritesErrorState extends HomeState {
  final String error;

  FavoritesErrorState({required this.error});
}
//end favourites states

//cart get data states
class CartLoadingState extends HomeState{}
class CartSuccessState extends HomeState{
  final CartModel cartModel;

  CartSuccessState({required this.cartModel});
}
class CartErrorState extends HomeState{
  final String error;

  CartErrorState({required this.error});
}

//cart post data states
class CartPostLoadingState extends HomeState{}
class CartPostSuccessState extends HomeState{
  final CartModel cartModel;

  CartPostSuccessState({required this.cartModel});
}
class CartPostErrorState extends HomeState{
  final String error;

  CartPostErrorState({required this.error});
}