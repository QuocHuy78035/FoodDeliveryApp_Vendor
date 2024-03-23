import 'package:ddnangcao_project/features/order/controllers/order_controller.dart';
import 'package:flutter/material.dart';

import '../models/order.dart';

class OrderProvider extends ChangeNotifier{
  late List<Orders> listOrderScheduled = [];
  late bool isLoading = false;
  final OrderController orderController = OrderController();

  void getAllOrder() async {
    isLoading = true;
    try{
      listOrderScheduled = await orderController.getAllOrdersScheduled();
    }catch(e){
      print("fail to get all order scheduled provider");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}