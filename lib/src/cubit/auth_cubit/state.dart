import 'package:shop2/src/core/models/cart_model.dart';
import 'package:shop2/src/core/models/categories_model.dart';
import 'package:shop2/src/core/models/favourites_model.dart';
import 'package:shop2/src/core/models/home_model.dart';
import 'package:shop2/src/core/models/product_details_model.dart';
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

//new data state
class HomeLoadingState extends ShopState {
  final HomeModel? homeModel;

  HomeLoadingState({required this.homeModel});
}

//old data state
class HomeSuccessState extends ShopState {
  final HomeModel? homeModel;

  HomeSuccessState({required this.homeModel});
}

class HomeErrorState extends ShopState {
  final String error;

  HomeErrorState({required this.error});
}
//end pagination states

//bottom navigation bar state
class ChangeBottomNavigationState extends ShopState {}

//password field visibility state
class ChangePasswordVisibilityState extends ShopState {}

//get setting states
class SettingsLoadingState extends ShopState {}

class SettingsSuccessState extends ShopState {
  final UserModel? userModel;

  SettingsSuccessState({required this.userModel});
}

class SettingsErrorState extends ShopState {
  final String error;

  SettingsErrorState({required this.error});
}

//settings after editing states
class UpdateLoadingState extends ShopState {}

class UpdateSuccessState extends ShopState {
  final UserModel? userModel;

  UpdateSuccessState({required this.userModel});
}

class UpdateErrorState extends ShopState {
  final String error;

  UpdateErrorState({required this.error});
}
//end settings states

//categories states
class CategoriesLoadingState extends ShopState {}

class CategoriesSuccessState extends ShopState {
  final CategoriesModel? categoriesModel;

  CategoriesSuccessState({required this.categoriesModel});
}

class CategoriesErrorState extends ShopState {
  final String error;

  CategoriesErrorState({required this.error});
}
//end categories states

//change favourites states
class ChangeLoadingSuccessState extends ShopState {}

class CategoriesDetailsLoadingState extends ShopState {}

class CategoriesDetailsSuccessState extends ShopState {
  final CategoriesModel? categoriesModel;

  CategoriesDetailsSuccessState({required this.categoriesModel});
}

class CategoriesDetailsErrorState extends ShopState {
  final String error;

  CategoriesDetailsErrorState({required this.error});
}
//end categories states

//change favourites states
// class ChangeLoadingSuccessState extends HomeState {}

class ChangeFavoriteSuccessState extends ShopState {
  final ChangeFavouritesModel? changeFavouritesModel;

  ChangeFavoriteSuccessState({required this.changeFavouritesModel});
}

class ChangeFavoritesErrorState extends ShopState {
  final String error;

  ChangeFavoritesErrorState({required this.error});
}

//get favourites data states
class GetFavoritesLoadingState extends ShopState {}

class FavoritesSuccessState extends ShopState {
  final FavouriteModel? favouriteModel;

  FavoritesSuccessState({required this.favouriteModel});
}

class FavoritesErrorState extends ShopState {
  final String error;

  FavoritesErrorState({required this.error});
}
//end favourites states

//cart get data states
class CartLoadingState extends ShopState{}
class CartSuccessState extends ShopState{
  final CartModel cartModel;

  CartSuccessState({required this.cartModel});
}
class CartErrorState extends ShopState{
  final String error;

  CartErrorState({required this.error});
}

//cart post data states
class CartPostLoadingState extends ShopState{}
class CartPostSuccessState extends ShopState{
  final CartModel cartModel;

  CartPostSuccessState({required this.cartModel});
}
class CartPostErrorState extends ShopState{
  final String error;

  CartPostErrorState({required this.error});
}

//cart quantity ++ --

class CartQuantityLoadingState extends ShopState{}
class CartQuantitySuccessState extends ShopState{
  final CartModel cartModel;

  CartQuantitySuccessState({required this.cartModel});
}

class CartQuantityErrorState extends ShopState{
  final String error;

  CartQuantityErrorState({required this.error});
}

// get single product data
class SingleProductLoading extends ShopState{}
class SingleProductSuccess extends ShopState{
  final ProductDetailsModel singleProduct;

  SingleProductSuccess({required this.singleProduct});
}

class SingleProductError extends ShopState{
  final String error;

  SingleProductError({required this.error});
}