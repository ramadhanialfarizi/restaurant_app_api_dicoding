import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view_model/home_provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/widget/search_button.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final prov = Provider.of<HomeProvider>(context, listen: false);
      prov.getAllRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Hi, Welcome',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Recomendation restaurant for you',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SearchButton(),
                const SizedBox(
                  height: 40,
                ),
                Consumer<HomeProvider>(
                  builder: (context, restaurant, __) {
                    if (restaurant.state == ResultState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (restaurant.state == ResultState.hasData) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: restaurant.restoList.restaurants.length,
                        itemBuilder: (context, index) {
                          var initial = restaurant.restoList.restaurants[index];
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        'https://restaurant-api.dicoding.dev/images/small/${initial.pictureId}',
                                        scale: 3.9,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            initial.name.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
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
                                              Text(initial.city.toString()),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  color: Colors.amber),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${initial.rating}',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (restaurant.state == ResultState.noData) {
                      return Center(
                        child: Material(
                          child: Text(restaurant.message),
                        ),
                      );
                    } else if (restaurant.state == ResultState.error) {
                      return Center(
                        child: Material(
                          child: Text(restaurant.message),
                        ),
                      );
                    } else {
                      return Center(
                        child: Material(
                          child: Text(''),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
