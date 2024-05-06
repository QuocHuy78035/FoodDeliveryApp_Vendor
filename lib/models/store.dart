import 'package:ddnangcao_project/models/category.dart';

class StoreModel {
  String? id;
  String? name;
  String? image;
  String? address;
  String? rating;
  String? timeOpen;
  String? timeClose;
  double? longitude;
  double? latitude;
  String? vendor;
  List<Category>? categories;

  StoreModel({
    this.id,
    this.name,
    this.image,
    this.address,
    this.rating,
    this.timeOpen,
    this.timeClose,
    this.longitude,
    this.latitude,
    this.vendor,
    this.categories,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      address: json['address'],
      rating: json['rating'],
      timeOpen: json['time_open'],
      timeClose: json['time_close'],
      longitude: json['longtitude']?.toDouble(),
      latitude: json['latitude']?.toDouble(),
      vendor: json['vendor'],
      categories: json['categories'] != null
          ? List<Category>.from(
          json['categories'].map((x) => Category.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['address'] = this.address;
    data['rating'] = this.rating;
    data['time_open'] = this.timeOpen;
    data['time_close'] = this.timeClose;
    data['longtitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['vendor'] = this.vendor;
    final categories = this.categories;
    if (categories != null) {
      data['categories'] = categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
