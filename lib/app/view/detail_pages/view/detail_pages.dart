import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view_model/detail_provider.dart';

import 'widget/drink_menu.dart';
import 'widget/food_menu.dart';

class DetailPages extends StatefulWidget {
  const DetailPages({super.key, this.restaurantID});

  final String? restaurantID;

  @override
  State<DetailPages> createState() => _DetailPagesState();
}

class _DetailPagesState extends State<DetailPages> {
  @override
  void initState() {
    super.initState();
    getDetailRestaurant();
  }

  void getDetailRestaurant() {
    context.read<DetailProvider>().getDetailRestaurant(widget.restaurantID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<DetailProvider>(
          builder: (context, detailRestaurant, __) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/large/${detailRestaurant.restaurantDetailModel?.restaurant.pictureId}'),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${detailRestaurant.restaurantDetailModel?.restaurant.name}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              '${detailRestaurant.restaurantDetailModel?.restaurant.city}'),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              '${detailRestaurant.restaurantDetailModel?.restaurant.rating}'),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${detailRestaurant.restaurantDetailModel?.restaurant.description}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Menu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.food_bank),
                          SizedBox(
                            width: 6,
                          ),
                          Text('Makanan'),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FoodMenu(menu: detailRestaurant.restaurantDetailModel),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.local_drink),
                          SizedBox(
                            width: 6,
                          ),
                          Text('Minuman'),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DrinkMenu(menu: detailRestaurant.restaurantDetailModel),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
