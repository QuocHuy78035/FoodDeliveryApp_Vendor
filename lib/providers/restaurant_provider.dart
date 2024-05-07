import 'dart:io';

import 'package:ddnangcao_project/features/restaurants/controllers/res_controller.dart';
import 'package:ddnangcao_project/models/store.dart';
import 'package:flutter/cupertino.dart';

class RestaurantProvider extends ChangeNotifier{
  List<StoreModel> storeModel = [];
  bool isLoading = false;
  final RestaurantController restaurantController = RestaurantController();

  findAllStore() async {
    try{
      isLoading = true;
      storeModel = await restaurantController.findAllStoreByVendor();
    }catch(e){
      throw Exception(e);
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }


  editRes(
      String resId,
      String storeName,
      String timeOpen,
      String timeClose,
      File image,
      ) async {
    try {
      await restaurantController.editRes(
          resId, storeName, timeOpen, timeClose, image);
    } catch (e) {
      throw Exception(e.toString());
    } finally {}
  }
}