import 'package:ddnangcao_project/models/food.dart';

class Statistic {
  String? id;
  int? numberOfSuccessfulOrders;
  int? revenue;
  Store? store;

  Statistic({
    this.id,
    this.numberOfSuccessfulOrders,
    this.revenue,
    this.store,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      id: json['_id'],
      numberOfSuccessfulOrders: json['numberOfSuccessfulOrders'],
      revenue: json['revenue'],
      store: json['store'] != null ? Store.fromJson(json['store']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['numberOfSuccessfulOrders'] = numberOfSuccessfulOrders;
    data['revenue'] = revenue;
    final store = this.store;
    if (store != null) {
      data['store'] = store.toJson();
    }
    return data;
  }
}