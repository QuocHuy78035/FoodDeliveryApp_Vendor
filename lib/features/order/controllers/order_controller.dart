import 'dart:convert';

import 'package:ddnangcao_project/api_services.dart';
import 'package:ddnangcao_project/features/order/controllers/i_order.dart';
import 'package:ddnangcao_project/models/order.dart';

class OrderController implements IOrder{
  final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
  @override
  Future<List<Orders>> getAllOrdersScheduled() async{
    List<Orders> listOrder = [];
    final response = await apiServiceImpl.get(url: "order?status=pending&sort=createdAt");
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if(data['status'] == 200){
      final List<dynamic> ordersData = data['metadata']['orders'];
      listOrder = ordersData.map((orderJson) => Orders.fromJson(orderJson)).toList();
    }else{
      print("Fail to get all order");
    }return listOrder;
  }

}