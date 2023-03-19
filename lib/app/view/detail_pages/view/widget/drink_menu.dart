import 'package:flutter/material.dart';

import '../../model/restaurant_detail_model.dart';

class DrinkMenu extends StatefulWidget {
  const DrinkMenu({super.key, required this.menu});

  final RestaurantDetailModel? menu;

  @override
  State<DrinkMenu> createState() => _DrinkMenuState();
}

class _DrinkMenuState extends State<DrinkMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.menu?.restaurant.menus.drinks.length,
        itemBuilder: (context, index) {
          return SizedBox(
            // width: 200,
            child: Card(
              clipBehavior: Clip.antiAlias,
              color: const Color.fromARGB(255, 255, 197, 97),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/drink_image.jpeg',
                        fit: BoxFit.contain,
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
                            '${widget.menu?.restaurant.menus.drinks[index].name}',
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
