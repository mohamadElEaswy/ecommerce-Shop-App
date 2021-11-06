class ProductDetailsModel {
  late bool status;
  late dynamic message;
  late Data data;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

}

class Data {
  late int id;
  late int price;
  late int oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;
  late List<String> images;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    images = json['images'].cast<String>();
  }

}

