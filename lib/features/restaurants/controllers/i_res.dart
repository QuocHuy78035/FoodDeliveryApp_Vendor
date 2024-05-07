import 'dart:io';

import '../../../models/store.dart';

abstract class IRestaurant{
  Future<List<StoreModel>> findAllStoreByVendor();
  Future<int> editRes(String storeId, String resName, String timeOpen, String timeClose, File? file);

}