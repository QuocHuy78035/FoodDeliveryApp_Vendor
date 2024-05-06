import 'dart:convert';

import 'package:ddnangcao_project/api_services.dart';
import 'package:ddnangcao_project/features/restaurants/controllers/i_res.dart';
import 'package:ddnangcao_project/models/store.dart';

class RestaurantController implements IRestaurant{
  final ApiServiceImpl apiService = ApiServiceImpl();
  @override
  Future<List<StoreModel>> findAllStoreByVendor() async {
    final response = await apiService.get(url: "store/vendor");
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data['status'] == 200) {
      final List<dynamic> storeList = jsonDecode(response.body)["metadata"];
      return storeList.map((storeJson) => StoreModel.fromJson(storeJson)).toList();
    } else {
      throw Exception('Failed to load stores');
    }
  }
}