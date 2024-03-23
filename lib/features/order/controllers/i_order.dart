import 'package:ddnangcao_project/models/order.dart';

abstract class IOrder{
  Future<List<Orders>> getAllOrdersScheduled();
}