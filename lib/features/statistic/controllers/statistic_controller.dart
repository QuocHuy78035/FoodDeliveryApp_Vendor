import 'dart:convert';

import 'package:ddnangcao_project/api_services.dart';
import 'package:ddnangcao_project/features/statistic/controllers/i_statistic.dart';
import 'package:ddnangcao_project/models/stastic.dart';

import '../../../models/revenue_by_year.dart';

class StatisticController implements IStatistic{
  final ApiServiceImpl apiService = ApiServiceImpl();
  @override
  Future<List<Statistic>> getRevenueByStoreId(String storeId) async {
    List<Statistic> statistic = [];
    final response = await apiService.get(url: 'statistic/revenueofstore?store=$storeId');
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] == 200) {
      final List<dynamic> statisticList = data['metadata']['statistic'];
      statistic = statisticList.map((statisticJson) => Statistic.fromJson(statisticJson)).toList();
    } else {
      throw Exception('Failed to fetch revenue statistics');
    }
    return statistic;
  }

  @override
  Future<List<StoreRevenue>> getRevenueByStoreIdAndMonth(String storeId, int year) async {
    List<StoreRevenue> statistic = [];
    final response = await apiService.get(url: 'statistic/revenueofstorebyyear?store=$storeId&year=$year');
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] == 200) {
      final List<dynamic> statisticList = data['metadata']['statistic'];
      statistic = statisticList.map((statisticJson) => StoreRevenue.fromJson(statisticJson)).toList();
    } else {
      throw Exception('Failed to fetch revenue statistics');
    }
    return statistic;
  }

}