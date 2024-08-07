import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorites_pages/view/favorite_page.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view/widget/sidebar.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view_model/home_provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/settings_page/view/settings_page.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/card_item.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/empty_data.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/error.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/skeleton_loading.dart';

import '../../../../core/utils/constant.dart';
import 'widget/search_button.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  static const String routes = "/home";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(context: context),
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
        drawer: Consumer<HomeProvider>(
          builder: (context, value, child) {
            return Sidebar(
              username: _controller.userName,
              screenKey: value.screenKey,
              onLogoutPress: () {
                _controller.doLogout(context);
              },
              onFavoritePress: () {
                _controller.gotoFavorite(context);
              },
              onHomePress: () {
                _controller.gotoHome(context);
              },
              onSettingsPress: () {
                _controller.gotoSettings(context);
              },
            );
          },
        ),
        appBar: BaseAppBar.baseAppBar(context),
        body: getWidget(_controller));
  }

  getWidget(HomeProvider controller) {
    return Consumer<HomeProvider>(
      builder: (context, homeController, child) {
        if (homeController.screenKey == ScreenKey.homeScreen.name) {
          return homeWidget(controller, context);
        }
        if (homeController.screenKey == ScreenKey.favoriteScreen.name) {
          return const FavoritePage();
        }
        if (homeController.screenKey == ScreenKey.settingsScreen.name) {
          return const SettingPages();
        }

        return const SizedBox();
      },
    );
  }

  homeWidget(HomeProvider controller, context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.doRefresh();
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
                Consumer<HomeProvider>(
                  builder: (context, value, child) {
                    if (value.loadingNameState == ResultState.loading) {
                      return SizedBox(
                        width: 300,
                        height: 380,
                        child: SkeletonLoadingComponent(
                            child: Container(
                          color: Colors.white,
                        )),
                      );
                    } else {
                      return Text(
                        'Hi, Welcome ${controller.userName}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
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
                SearchButton(
                  onTap: () {
                    controller.gotoSearch(context);
                  },
                ),
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
                        itemCount: restaurant.restoList?.restaurants?.length,
                        itemBuilder: (context, index) {
                          var initial =
                              restaurant.restoList?.restaurants?[index];

                          return FutureBuilder(
                              future: controller
                                  .getCacheDataById(initial?.id ?? ""),
                              builder: (context, snapshot) {
                                var isFavoriteData = snapshot.data;
                                // LogUtility.writeLog("status ; ${isFavorite.}");
                                return CardItem(
                                  imageLink:
                                      'https://restaurant-api.dicoding.dev/images/medium/${initial?.pictureId}',
                                  name: initial?.name ?? "",
                                  location: initial?.city ?? "",
                                  rating: (initial?.rating ?? "0.0").toString(),
                                  onTap: () {
                                    controller.gotoDetail(
                                        context, initial ?? Restaurant());
                                  },
                                  isFavorite: initial?.id == isFavoriteData?.id,
                                  onFavoriteTap: () {
                                    bool status =
                                        initial?.id == isFavoriteData?.id;
                                    controller.favoriteHandle(
                                        initial ?? Restaurant(), status);
                                  },
                                );
                              });
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
    );
  }
}
