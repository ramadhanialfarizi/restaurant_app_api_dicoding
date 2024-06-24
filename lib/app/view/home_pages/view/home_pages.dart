import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view/detail_pages.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view/widget/sidebar.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view_model/home_provider.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/empty_data.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/error.dart';

import '../../../../core/utils/enum.dart';
import 'widget/search_button.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  static const String routes = "/home";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const _HomePagesBuilder(),
    );
  }
}

class _HomePagesBuilder extends StatelessWidget {
  const _HomePagesBuilder();

  @override
  Widget build(BuildContext context) {
    var _controller = context.read<HomeProvider>();
    return BaseWidgetContainer(
      drawer: Sidebar(
        username: _controller.userName,
        onLogoutPress: () {
          _controller.doLogout(context);
        },
      ),
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          _controller.doRefresh();
        },
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
                    'Hi, Welcome ${_controller.userName}',
                    style: const TextStyle(
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
