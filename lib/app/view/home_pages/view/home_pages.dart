import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view/detail_pages.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view/sidebar.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view_model/home_provider.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/empty_data.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/error.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/enum.dart';
import 'widget/search_button.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  SharedPreferences? loginData;
  String userName = " ";

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      userName = loginData!.getString('userName').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getListRestaurant();
    initial();
  }

  void getListRestaurant() {
    context.read<HomeProvider>().getAllRestaurantList();
  }

  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Hi, Welcome $userName',
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
                          itemCount: restaurant.restoList?.restaurants.length,
                          itemBuilder: (context, index) {
                            var initial =
                                restaurant.restoList?.restaurants[index];
                            return InkWell(
                              onTap: () {
                                var restaurantID = initial.id;
                                //print(restaurantID);
                                DetailPages(
                                  restaurantID: restaurantID,
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPages(
                                      restaurantID: restaurantID,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.network(
                                          'https://restaurant-api.dicoding.dev/images/medium/${initial?.pictureId}',
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
                                              initial!.name.toString(),
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
                        return const EmptyData();
                      } else if (restaurant.state == ResultState.error) {
                        return ErrorData(
                          message: restaurant.message,
                        );
                      } else {
                        return const Center(
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
      ),
    );
  }
}
