import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view_model/detail_provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/global_widget/empty_data.dart';
import '../../../../core/global_widget/error.dart';
import 'widget/drink_menu.dart';
import 'widget/food_menu.dart';

class DetailPages extends StatelessWidget {
  const DetailPages({
    super.key,
    this.restaurantID,
    this.restaurantData,
  });

  static const String routes = "/detail";
  final String? restaurantID;
  final Restaurant? restaurantData;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailProvider(
        restaurantID: restaurantID ?? "",
        restaurantData: restaurantData,
      ),
      child: const _DetailPagesBuilder(),
    );
  }
}

class _DetailPagesBuilder extends StatelessWidget {
  const _DetailPagesBuilder();

  @override
  Widget build(BuildContext context) {
    var controller = context.read<DetailProvider>();
    return BaseWidgetContainer(
      body: Stack(
        children: [
          Consumer<DetailProvider>(builder: (context, detailRestaurant, child) {
            return ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/large/${detailRestaurant.restaurantDetailModel?.restaurant.pictureId}'),
            );
          }),
          Padding(
            padding: EdgeInsets.only(
              top: Constant.getFullHeight(context) * 0.33,
            ),
            child: SingleChildScrollView(
              child: Consumer<DetailProvider>(
                builder: (context, detailRestaurant, __) {
                  if (detailRestaurant.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (detailRestaurant.state == ResultState.hasData) {
                    return Column(
                      children: [
                        // ClipRRect(
                        //   borderRadius: const BorderRadius.only(
                        //     bottomLeft: Radius.circular(30),
                        //     bottomRight: Radius.circular(30),
                        //   ),
                        //   child: Image.network(
                        //       'https://restaurant-api.dicoding.dev/images/large/${detailRestaurant.restaurantDetailModel?.restaurant.pictureId}'),
                        // ),

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
                                height: 20,
                              ),
                              Consumer<DetailProvider>(
                                builder: (context, value, child) {
                                  return ElevatedButton.icon(
                                      onPressed: () {
                                        controller.handleFavoriteButton();
                                      },
                                      label: value.isFavorite
                                          ? const Text(
                                              "Remove favorite",
                                              style: TextStyle(
                                                  color: ColorsConstant
                                                      .secondaryColors),
                                            )
                                          : const Text(
                                              "Add to favorite",
                                              style: TextStyle(
                                                  color: ColorsConstant
                                                      .secondaryColors),
                                            ),
                                      icon: value.isFavorite
                                          ? const Icon(
                                              Icons.favorite,
                                              color: ColorsConstant
                                                  .secondaryColors,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              color: ColorsConstant
                                                  .secondaryColors,
                                            ));
                                },
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
                              const Row(
                                children: [
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
                              FoodMenu(
                                  menu: detailRestaurant.restaurantDetailModel),
                              const SizedBox(
                                height: 30,
                              ),
                              const Row(
                                children: [
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
                              DrinkMenu(
                                  menu: detailRestaurant.restaurantDetailModel),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  child: const Text('See Comment'),
                                  onPressed: () {
                                    // var initial = detailRestaurant
                                    //     .restaurantDetailModel!.restaurant;

                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) =>
                                          commentSection(controller, context),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (detailRestaurant.state == ResultState.noData) {
                    return const EmptyData();
                  } else if (detailRestaurant.state == ResultState.error) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: ErrorData(),
                    );
                  } else {
                    return const Center(
                      child: Material(
                        child: Text(''),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commentSection(DetailProvider controller, context) {
    var commentData =
        controller.restaurantDetailModel?.restaurant.customerReviews;
    return Container(
      //decoration: ,
      margin: const EdgeInsets.all(16),
      child: Column(
        //mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Comment Section",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: commentData?.length,
              itemBuilder: (context, index) {
                var initial = commentData![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF76b5c5),
                    child: Text(initial.name[0]),
                  ),
                  title: Text('${initial.name} (${initial.date})'),
                  subtitle: Text(initial.review),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 20),
            child: SizedBox(
              height: 50,
              child: Form(
                key: controller.formKey,
                child: TextFormField(
                  controller: controller.commentInputController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(20.0),
                    hintText: "type a comment...",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 234, 234, 234),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        var validForm =
                            controller.formKey.currentState!.validate();

                        var restaurantID = controller.restaurantID;
                        var name = controller.userName;
                        var review = controller.commentInputController.text;

                        if (validForm) {
                          controller.addReview(restaurantID, name, review);

                          Navigator.pop(context);
                          controller.commentInputController.clear();
                        }
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* please input your comment';
                    }

                    return null;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
