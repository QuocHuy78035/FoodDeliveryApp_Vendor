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
      throw Exception(e.toString);
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}