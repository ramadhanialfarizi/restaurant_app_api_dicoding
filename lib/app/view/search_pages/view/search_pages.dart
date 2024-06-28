import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';

import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/view_model/search_provider.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/card_item.dart';
import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/error.dart';

import '../../../../core/global_widget/empty_data.dart';

class SearchPages extends StatelessWidget {
  const SearchPages({super.key});

  static const String routes = "/search";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: const _SearchPagesBuilder(),
    );
  }
}

class _SearchPagesBuilder extends StatelessWidget {
  const _SearchPagesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var _controller = context.read<SearchProvider>();
    return BaseWidgetContainer(
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
                const Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 35,
                      color: ColorsConstant.primaryColors,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Find Restaurant',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: _controller.searchInputController,
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
                              .getSearchListRestaurant();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<SearchProvider>(
                  builder: (context, searchRestaurant, child) {
                    if (searchRestaurant.state == ResultState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (searchRestaurant.state == ResultState.hasData) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: searchRestaurant
                            .searchRestaurantModel?.restaurants?.length,
                        itemBuilder: (context, index) {
                          var initial = searchRestaurant
                              .searchRestaurantModel?.restaurants?[index];
                          return FutureBuilder(
                              future: _controller
                                  .getCacheDataById(initial?.id ?? ""),
                              builder: (context, snapshot) {
                                var isFavoriteData = snapshot.data;
                                return CardItem(
                                  imageLink:
                                      'https://restaurant-api.dicoding.dev/images/medium/${initial?.pictureId}',
                                  name: initial!.name.toString(),
                                  location: initial.city.toString(),
                                  rating: initial.rating.toString(),
                                  onTap: () {
                                    Restaurant data = Restaurant()
                                      ..city = initial.city
                                      ..description = initial.description
                                      ..id = initial.id
                                      ..name = initial.name
                                      ..pictureId = initial.pictureId
                                      ..rating = initial.rating;
                                    _controller.gotoDetail(context, data);
                                  },
                                  onFavoriteTap: () {
                                    Restaurant data = Restaurant()
                                      ..city = initial.city
                                      ..description = initial.description
                                      ..id = initial.id
                                      ..name = initial.name
                                      ..pictureId = initial.pictureId
                                      ..rating = initial.rating;

                                    bool favorite =
                                        initial.id == isFavoriteData?.id;
                                    _controller.favoriteHandle(data, favorite);
                                  },
                                  isFavorite: initial.id == isFavoriteData?.id
                                      ? true
                                      : false,
                                );
                              });
                        },
                      );
                    } else if (searchRestaurant.state == ResultState.error) {
                      return const ErrorData();
                    } else {
                      return const EmptyData();
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
