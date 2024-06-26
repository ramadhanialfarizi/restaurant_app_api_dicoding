import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorites_pages/view_model/favorite_page_provider.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/card_item.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/empty_data.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/error.dart';
import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritePageProvider(),
      child: const _FavoritePageBuilder(),
    );
  }
}

class _FavoritePageBuilder extends StatelessWidget {
  const _FavoritePageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var _controller = context.read<FavoritePageProvider>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: 35,
                  color: ColorsConstant.secondaryColors,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Favorites',
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
            Consumer<FavoritePageProvider>(
              builder: (context, viewRender, child) {
                if (viewRender.state == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (viewRender.state == ResultState.hasData) {
                  return SizedBox(
                    height: Constant.getFullHeight(context) * 0.80,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: viewRender.favoriteRestaurantList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = viewRender.favoriteRestaurantList[index];
                        return CardItem(
                          imageLink:
                              'https://restaurant-api.dicoding.dev/images/medium/${data.pictureId}',
                          name: data.name ?? "",
                          location: data.city ?? "",
                          rating: (data.rating ?? "0.0").toString(),
                          onTap: () {
                            _controller.gotoDetailPage(context, data);
                          },
                          isFavorite: true,
                          onFavoriteTap: () {
                            _controller.deleteFavorites(data.id ?? "");
                          },
                        );
                      },
                    ),
                  );
                } else if (viewRender.state == ResultState.noData) {
                  return const EmptyData();
                } else {
                  return const ErrorData(
                    message: "error, please try again",
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
