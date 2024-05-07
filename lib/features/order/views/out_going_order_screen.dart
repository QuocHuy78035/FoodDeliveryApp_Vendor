import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/order_provider.dart';
import '../../../utils/size_lib.dart';
import '../widgets/order_items.dart';
import 'detail_order_screen.dart';

class OutGoingOrderScreen extends StatefulWidget {
  const OutGoingOrderScreen({super.key});

  @override
  State<OutGoingOrderScreen> createState() => _OutGoingOrderScreenState();
}

class _OutGoingOrderScreenState extends State<OutGoingOrderScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).getAllOrderOutGoing();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer<OrderProvider>(
            builder: (context, value, child) {
              if (value.listOrderOutGoing.isEmpty) {
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
                    itemCount: value.listOrderOutGoing.length,
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
                                    foodCost: value.listOrderOutGoing[index].checkout?.totalPrice,
                                    phone: value.listOrderOutGoing[index].phoneNumber,
                                    foods: value.listOrderOutGoing[index].foods ?? [],
                                    avt: value.listOrderOutGoing[index].user?.avt ?? "",
                                    note: value.listOrderOutGoing[index].note,
                                    userName: value.listOrderOutGoing[index].user?.userName ?? "",
                                    subTotal: "${value.listOrderOutGoing[index].checkout
                                        ?.total}",
                                    distance: value.listOrderOutGoing[index].distance ?? "",
                                    id: value.listOrderOutGoing[index].sId ?? "",
                                    quantity: value.listOrderOutGoing[index].foods
                                    !.map((food) => food.quantity as int)
                                        .toList(), address: value.listOrderOutGoing[index].shippingAddress ?? "",
                                  );
                                },
                              ),
                            );
                          },
                          child: OrderItem(
                            status: "Food is being assigned",
                            dished: value.listOrderOutGoing[index].foods!.length,
                            totalApplyDiscount:
                            NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                                .format(value.listOrderOutGoing[index].checkout
                                ?.totalPrice),
                            name:
                            value.listOrderOutGoing[index].user?.userName ?? "",
                            distance: value.listOrderOutGoing[index].distance ?? "",
                            pickUp: value.listOrderOutGoing[index].updatedAt ?? "",
                            createdAt: value.listOrderOutGoing[index].sId ?? "",
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
