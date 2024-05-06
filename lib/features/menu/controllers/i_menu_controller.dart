import 'dart:io';

import 'package:ddnangcao_project/models/food.dart';

import '../../../models/category.dart';

abstract class IMenuController{
  Future<int> createStore(String name, String address, File image, String timeOpen, String timeClose, double latitude, double longtitude);
  Future<List<Category>> getAllCategory();
  Future<int> upLoadFood(String foodName, String cateId, String resId, String price, String quantity, File image);
  Future<List<Food>> getAllFoodByStoreId(String storeId);
  Future<int> editFood(String foodId, String foodName, String categoryId, String price, String left, File? file);
}