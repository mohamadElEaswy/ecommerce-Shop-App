// ignore_for_file: prefer_void_to_null

class ChangeFavouritesModel {
  String? message;
  bool? status;

  ChangeFavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class FavouriteModel {
  late final bool status;
  late final Null message;
  late final Data data;

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late final int currentPage;
  List<FavData> dataLoad = [];
  late final String firstPageUrl;
  late final int from;
  late final int lastPage;
  late final String lastPageUrl;
  late final Null nextPageUrl;
  late final String path;
  late final int perPage;
  late final Null prevPageUrl;
  late final int to;
  late final int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      // data = List<DataModel>();
      json['data'].forEach((v) {
        dataLoad.add(FavData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavData {
  late final int id;
  late final Product product;

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = (json['product'] != null
        ? Product.fromJson(json['product'])
        : null)!;
  }
}

class Product {
  late final int id;
  late final dynamic price;
  late final dynamic oldPrice;
  late final dynamic discount;
  late final String image;
  late final String name;
  late final String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}