import '../../../models/revenue_by_year.dart';
import '../../../models/stastic.dart';

abstract class IStatistic{
  Future<List<Statistic>> getRevenueByStoreId(String storeId);
  Future<List<StoreRevenue>> getRevenueByStoreIdAndMonth(String storeId, int month);
}