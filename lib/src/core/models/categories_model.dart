class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;


  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  late final int currentPage;
  List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach(
            (v) {
          data.add(DataModel.fromJson(v));
        },
      );
    }
  }
}

class DataModel {
  late final int id;
  late final String name;
  late final String image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}