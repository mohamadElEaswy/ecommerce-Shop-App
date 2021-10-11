abstract class ShopState{}

class InitialShopState extends ShopState{}

class LoadingShopState extends ShopState{}

class LoginShopState extends ShopState{}

class LoginErrorShopState extends ShopState{
  final String error;

  LoginErrorShopState(this.error);
}