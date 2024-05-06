import '../../../models/store.dart';

abstract class IRestaurant{
  Future<List<StoreModel>> findAllStoreByVendor();
}