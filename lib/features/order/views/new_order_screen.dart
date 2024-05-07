import 'package:ddnangcao_project/features/order/views/detail_order_screen.dart';
import 'package:ddnangcao_project/providers/order_provider.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/order_items.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).getAllOrderNew();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer<OrderProvider>(
            builder: (context, value, child) {
              if (value.listOrderNewed.isEmpty) {
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
                    itemCount: value.listOrderNewed.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailOrderScreen(
                                  isOutGoing: true,
                                  index: index,
                                  foodCost: value.listOrderNewed[index].checkout?.totalPrice,
                                  phone: value.listOrderNewed[index].phoneNumber,
                                  foods: value.listOrderNewed[index].foods ?? [],
                                  avt: value.listOrderNewed[index].user?.avt ?? "",
                                  note: value.listOrderNewed[index].note,
                                  userName: value.listOrderNewed[index].user?.userName ?? "",
                                  subTotal: "${value.listOrderNewed[index].checkout
                                      ?.total}",
                                  distance: value.listOrderNewed[index].distance ?? "",
                                  id: value.listOrderNewed[index].sId ?? "",
                                  quantity: value.listOrderNewed[index].foods
                                  !.map((food) => food.quantity as int)
                                      .toList(), address: value.listOrderNewed[index].shippingAddress ?? "",
                                );
                              },
                            ),
                          );
                        },
                        child: OrderItem(
                          status: "Shipper is arriving",
                          dished: value.listOrderNewed[index].foods!.length,
                          totalApplyDiscount:
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(value.listOrderNewed[index].checkout
                              ?.totalPrice),
                          name:
                          value.listOrderNewed[index].user?.userName ?? "",
                          distance: value.listOrderNewed[index].distance ?? "",
                          pickUp: value.listOrderNewed[index].updatedAt ?? "",
                          createdAt: value.listOrderNewed[index].sId ?? "",
                        )
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

