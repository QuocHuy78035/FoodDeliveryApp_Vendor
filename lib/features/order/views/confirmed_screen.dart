import 'package:ddnangcao_project/features/order/views/detail_order_screen.dart';
import 'package:ddnangcao_project/providers/order_provider.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/order_items.dart';

class ConfirmedScreen extends StatefulWidget {
  const ConfirmedScreen({super.key});

  @override
  State<ConfirmedScreen> createState() => _ConfirmedScreenState();
}

class _ConfirmedScreenState extends State<ConfirmedScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).getAllOrderConfirmed();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer<OrderProvider>(
            builder: (context, value, child) {
              if (value.listOrderConfirmed.isEmpty) {
                return const Center(
                  child: Text("No have item"),
                );
              } else if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: 600,
                  width: GetSize.getWidth(context),
                  child: ListView.builder(
                    itemCount: value.listOrderConfirmed.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailOrderScreen(
                                  index: index,
                                  foodCost: value.listOrderConfirmed[index].checkout?.total,
                                  phone: value.listOrderConfirmed[index].phoneNumber,
                                  foods: value.listOrderConfirmed[index].foods ?? [],
                                  avt: value.listOrderConfirmed[index].user?.avt ?? "",
                                  note: value.listOrderConfirmed[index].note,
                                  userName: value.listOrderConfirmed[index].user?.userName ?? "",
                                  subTotal: "${value.listOrderConfirmed[index].checkout
                                      ?.total}",
                                  distance: value.listOrderConfirmed[index].distance ?? "",
                                  id: value.listOrderConfirmed[index].sId ?? "",
                                  quantity: value.listOrderConfirmed[index].foods
                                  !.map((food) => food.quantity as int)
                                      .toList(), address: value.listOrderConfirmed[index].shippingAddress ?? "",
                                );
                              },
                            ),
                          );
                        },
                        child: OrderItem(
                          status: "Waiting for shipper pickup",
                          dished: value.listOrderConfirmed[index].foods!.length,
                          totalApplyDiscount:
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(value.listOrderConfirmed[index].checkout
                              ?.total),
                          name:
                          value.listOrderConfirmed[index].user?.userName ?? "",
                          distance: value.listOrderConfirmed[index].distance ?? "",
                          pickUp: value.listOrderConfirmed[index].updatedAt ?? "",
                          createdAt: '',

                        ),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

