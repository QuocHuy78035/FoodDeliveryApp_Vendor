import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/restaurant_provider.dart';
import '../../../utils/size_lib.dart';
import '../../../widgets/loading_widget.dart';
import '../../statistic/views/statistic_screen.dart';

class AllStoreScreen extends StatefulWidget {
  const AllStoreScreen({super.key});

  @override
  State<AllStoreScreen> createState() => _AllStoreScreenState();
}

class _AllStoreScreenState extends State<AllStoreScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false).findAllStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurants"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              child: const Icon(
                Icons.add,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.black12.withOpacity(0.05),
              child: Consumer<RestaurantProvider>(
                builder: (BuildContext context, RestaurantProvider value,
                    Widget? child) {
                  if (value.storeModel.isEmpty) {
                    return const Center(
                      child: Center(
                        child: Text("No Have Item"),
                      ),
                    );
                  } else {
                    if (value.isLoading) {
                      return Container(
                        color: Colors.black12.withOpacity(0.05),
                        height: GetSize.getHeight(context) * 0.85,
                        width: GetSize.getWidth(context),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: value.storeModel.length,
                          itemBuilder: (context, index) =>
                              const NewsCardSkelton(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                        ),
                      );
                    } else {
                      return Container(
                        height: GetSize.getHeight(context) * .8,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.storeModel.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                         BarChartSample3(storeId: value.storeModel[index].id ?? "",),
                                  ),
                                );
                              },
                              child: Restaurant(
                                name: value.storeModel[index].name ?? '',
                                rating:
                                    value.storeModel[index].rating.toString(),
                                address: value.storeModel[index].address ?? "",
                                image: value.storeModel[index].image ?? '',
                                timeOpen:
                                    value.storeModel[index].timeOpen ?? '',
                                timeClode:
                                    value.storeModel[index].timeClose ?? '',
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Restaurant extends StatelessWidget {
  final String name;
  final String rating;
  final String address;
  final String image;
  final String timeOpen;
  final String timeClode;

  const Restaurant(
      {super.key,
      required this.name,
      required this.rating,
      required this.address,
      required this.image,
      required this.timeOpen,
      required this.timeClode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: GetSize.getWidth(context),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: GetSize.getWidth(context),
                    color: Colors.white,
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        height: GetSize.getHeight(context) / 4,
                        imageUrl: image,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: GetSize.getWidth(context) * 0.9,
                          child: Text(
                            name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: GetSize.getWidth(context) * 0.9,
                          child: Text(
                            address,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                  child: Image.asset(
                                      "assets/images/foods/timer.png"),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("$timeOpen - $timeClode")
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                  child: Image.asset(
                                      "assets/images/foods/star-Filled.png"),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(rating)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
