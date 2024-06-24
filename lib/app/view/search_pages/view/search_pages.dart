import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/view_model/search_provider.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/error.dart';

import '../../../../core/global_widget/empty_data.dart';
import '../../detail_pages/view/detail_pages.dart';

class SearchPages extends StatefulWidget {
  const SearchPages({super.key});

  static const String routes = "/search";

  @override
  State<SearchPages> createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPages> {
  TextEditingController searchInput = TextEditingController();

  @override
  void dispose() {
    searchInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, searchRestaurant, __) {
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
                      'Find Restaurant',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: searchInput,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(20.0),
                          hintText: "Search Restaurant...",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 234, 234, 234),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              context
                                  .read<SearchProvider>()
                                  .getSearchListRestaurant(searchInput.text);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (searchRestaurant.state == ResultState.loading) ...[
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ] else if (searchRestaurant.state ==
                        ResultState.hasData) ...[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: searchRestaurant
                            .searchRestaurantModel?.restaurants?.length,
                        itemBuilder: (context, index) {
                          var initial = searchRestaurant
                              .searchRestaurantModel?.restaurants?[index];
                          return InkWell(
                            onTap: () {
                              var restaurantID = initial.id;

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
                                      borderRadius: BorderRadius.circular(20.0),
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
                      ),
                    ] else if (searchRestaurant.state ==
                        ResultState.noData) ...[
                      const EmptyData(),
                    ] else if (searchRestaurant.state == ResultState.error) ...[
                      const ErrorData(),
                    ]
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
