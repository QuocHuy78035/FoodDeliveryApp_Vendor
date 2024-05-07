import 'package:ddnangcao_project/features/statistic/controllers/statistic_controller.dart';
import 'package:ddnangcao_project/models/stastic.dart';
import 'package:flutter/cupertino.dart';

import '../models/revenue_by_year.dart';

class StatisticProvider extends ChangeNotifier{
  final StatisticController statisticController = StatisticController();
  List<Statistic> statistic = [];
  List<StoreRevenue> storeRevenueByYear = [];
  getStatistic(String storeId) async {
    try{
      statistic = await statisticController.getRevenueByStoreId(storeId);
    }catch(e){
      throw Exception(e);
    }finally{
      notifyListeners();
    }
    return statistic;
  }

  Future<List<StoreRevenue>>getStatisticByStoreIdAndMonth(String storeId, int year) async {
    try{
      storeRevenueByYear = await statisticController.getRevenueByStoreIdAndMonth(storeId, year);
    }catch(e){
      throw Exception(e);
    }finally{
      notifyListeners();
    }
    return storeRevenueByYear;
  }
}