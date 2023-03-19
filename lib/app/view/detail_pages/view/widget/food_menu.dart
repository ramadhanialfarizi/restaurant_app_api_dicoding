import 'package:flutter/material.dart';

import '../../model/restaurant_detail_model.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({super.key, required this.menu});

  final RestaurantDetailModel? menu;

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: ListView.builder(
        //physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.menu?.restaurant.menus.foods.length,
        itemBuilder: (context, index) {
          return SizedBox(
            // width: 200,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              //clipBehavior: Clip.antiAlias,
              color: const Color.fromARGB(255, 255, 197, 97),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/food_image.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.menu?.restaurant.menus.foods[index].name}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text('IDR 5.000')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
