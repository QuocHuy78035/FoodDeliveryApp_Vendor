import 'dart:io';

import '../../../models/category.dart';

abstract class IMenuController{
  Future<List<Category>> getAllCategory();
  Future<int> upLoadFood(String foodName, String cateId, String resId, String price, String quantity, File image);
}