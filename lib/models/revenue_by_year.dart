import 'food.dart';

class StoreRevenue {
  String? id;
  int? numberOfSuccessfulOrders;
  double? revenue;
  Store? store;
  Map<String, MonthStatistic>? months;

  StoreRevenue({
    this.id,
    this.numberOfSuccessfulOrders,
    this.revenue,
    this.store,
    this.months,
  });

  factory StoreRevenue.fromJson(Map<String, dynamic> json) {
    return StoreRevenue(
      id: json['_id'],
      numberOfSuccessfulOrders: json['numberOfSuccessfulOrders'],
      // Cast revenue value to double
      revenue: json['revenue'].toDouble(),
      store: Store.fromJson(json['store']),
      months: (json['months'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, MonthStatistic.fromJson(value)),
      ),
    );
  }

    Map<String, dynamic> toJson() {
      return {
        '_id': id,
        'numberOfSuccessfulOrders': numberOfSuccessfulOrders,
        'revenue': revenue,
        'store': store?.toJson(),
        'months': months?.map((key, value) => MapEntry(key, value.toJson())),
      };
    }
}


class MonthStatistic {
  int? numberOfSuccessfulOrders;
  double? revenue;

  MonthStatistic({
    this.numberOfSuccessfulOrders,
    this.revenue,
  });

  factory MonthStatistic.fromJson(Map<String, dynamic> json) {
    return MonthStatistic(
      numberOfSuccessfulOrders: json['numberOfSuccessfulOrders'],
      revenue: json['revenue'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numberOfSuccessfulOrders': numberOfSuccessfulOrders,
      'revenue': revenue,
    };
  }
}