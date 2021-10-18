import 'package:flutter/material.dart';
import 'package:shop2/src/UI/screens/home/cart/cart.dart';
import 'package:shop2/src/UI/screens/home/categories/categories.dart';
import 'package:shop2/src/UI/screens/home/favorite/favorite.dart';
import 'package:shop2/src/UI/screens/home/home_screen.dart';
import 'package:shop2/src/UI/screens/home/setting/setting.dart';
import 'package:shop2/src/config/end_points.dart';
import 'package:shop2/src/core/models/cart_model.dart';
import 'package:shop2/src/core/models/categories_model.dart';
import 'package:shop2/src/core/models/favourites_model.dart';
import 'package:shop2/src/core/models/home_model.dart';
import 'package:shop2/src/core/models/user_model.dart';
import 'package:shop2/src/cubit/home_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop2/src/data/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());
  static HomeCubit get(context) => BlocProvider.of(context);

  /*manage bottom navigation bar*/
  int currentIndex = 0;
  List<Widget> body = [
    const Home(),
    const CategoriesScreen(),
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
      icon: Icon(Icons.category),
      label: 'Categories',
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

//TODO Don't forget the pagination
//get home products data
//with pagination
  List<Products> homeProducts = [];
  List<Banners> homeBanners = [];
  HomeModel? homeModel;
  void getHomeData() {
    emit(HomeLoadingState(homeModel: homeModel));
    DioHelper.get(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll(
          {
            element.id: element.inFavorites,
          },
        );
      });
      homeProducts = homeModel!.data.products;
      homeBanners = homeModel!.data.banners;
      emit(HomeSuccessState(homeModel: homeModel));
    }).catchError((e) {
      emit(HomeErrorState(error: e.toString()));
    });
  }

//get settings data
  UserModel? userModel;
  void getSettingsData() {
    emit(SettingsLoadingState());
    DioHelper.get(
      url: profile,
      token: token,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(SettingsSuccessState(userModel: userModel));
    }).catchError((e) {
      emit(SettingsErrorState(error: e.toString()));
    });
  }

//change settings data
  void updateSettingsData(
      {required String name, required String email, required String phone}) {
    emit(UpdateLoadingState());
    DioHelper.put(
        url: update,
        token: token,
        data: {'email': email, 'name': name, 'phone': phone}).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(UpdateSuccessState(userModel: userModel));
    }).catchError((e) {
      emit(UpdateErrorState(error: e.toString()));
    });
  }

  late List<DataModel> categoriesData = [];
// get categories data
  CategoriesModel? categoriesModel;
  late Map<int, bool?> favorites = {};

  void getCategoriesData() {
    emit(CategoriesLoadingState());

    DioHelper.get(
      url: categories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      categoriesData = categoriesModel!.data!.data;
      emit(CategoriesSuccessState(categoriesModel: categoriesModel));
    }).catchError((error) {
      emit(CategoriesErrorState(error: error.toString()));
    });
  }

  late CategoriesModel categoriesDetailsModel;
  late int catId;
  void getCategoriesDetails({required int categoryId}) {
    emit(CategoriesDetailsLoadingState());
    catId = categoryId;
    DioHelper.get(
      url: categories + '/$categoryId',
    ).then((value) {
      categoriesDetailsModel = CategoriesModel.fromJson(value.data);

      emit(CategoriesDetailsSuccessState(
          categoriesModel: categoriesDetailsModel));
    }).catchError((error) {
      emit(CategoriesDetailsErrorState(error: error.toString()));
    });
  }

  //change favourites
  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites({required int productId}) async {
    emit(ChangeLoadingSuccessState());
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoriteSuccessState(
        changeFavouritesModel: changeFavouritesModel));
    DioHelper.post(
      url: favorite,
      data: {
        'product_id': productId,
      },
      token: token,
    )
        .then((value) => {
              changeFavouritesModel =
                  ChangeFavouritesModel.fromJson(value.data),
              if (changeFavouritesModel!.status = !true)
                {favorites[productId] = !favorites[productId]!}
              else
                {getFavouritesData()},
              emit(ChangeFavoriteSuccessState(
                  changeFavouritesModel: changeFavouritesModel)),
            })
        .catchError((e) {
      favorites[productId] = !favorites[productId]!;
      emit(ChangeFavoritesErrorState(error: e.toString()));
    });
  }

//get favourites data
  late FavouriteModel favouriteModel;
  void getFavouritesData() {
    emit(GetFavoritesLoadingState());
    DioHelper.get(
      url: favorite,
      token: token,
    ).then((value) {
      // if(value.) {
        favouriteModel = FavouriteModel.fromJson(value.data);
        emit(FavoritesSuccessState(favouriteModel: favouriteModel));
      // }
    }).catchError((error) {
      print(error.toString());
      emit(FavoritesErrorState(error: error.toString()));
    });
  }

  late Map<int, bool?> cartData = {};
  late CartModel cartModel;
  //get cart data
  void getCartData() {
    emit(CartLoadingState());
    DioHelper.get(url: cart, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(CartSuccessState(cartModel: cartModel));
    }).catchError((e) {
      emit(CartErrorState(error: e.toString()));
    });
  }
  //*post to cart the products add and remove

//delete cart
//update cart
  CartModel? addToCart;
  void cartPost({required int productId}) {
    emit(CartPostLoadingState());
    DioHelper.post(
      url: cart,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      addToCart = CartModel.fromJson(value.data);
      if (addToCart!.status == true) {
        getCartData();
      }
      emit(CartPostSuccessState(cartModel: addToCart!));
    }).catchError((e) {
      CartPostErrorState(error: e.toString());
    });
  }
}
