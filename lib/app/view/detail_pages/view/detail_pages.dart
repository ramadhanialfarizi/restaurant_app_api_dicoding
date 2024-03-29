import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/view_model/detail_provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorite/model/add_favorite_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorite/view_model/favorite_provider.dart';
import 'package:restaurant_app_api_dicoding/core/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/global_widget/empty_data.dart';
import '../../../../core/global_widget/error.dart';
import 'widget/drink_menu.dart';
import 'widget/food_menu.dart';

class DetailPages extends StatefulWidget {
  const DetailPages({super.key, this.restaurantID});

  final String? restaurantID;

  @override
  State<DetailPages> createState() => _DetailPagesState();
}

class _DetailPagesState extends State<DetailPages> {
  SharedPreferences? loginData;
  String? userName;
  TextEditingController commentInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    commentInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getDetailRestaurant();
    init();
  }

  void init() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      userName = loginData!.getString('userName').toString();
    });
  }

  void getDetailRestaurant() {
    context.read<DetailProvider>().getDetailRestaurant(widget.restaurantID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer2<DetailProvider, FavoriteProvider>(
          builder: (context, detailRestaurant, favorite, __) {
            if (detailRestaurant.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (detailRestaurant.state == ResultState.hasData) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Stack(
                      children: [
                        Image.network(
                            'https://restaurant-api.dicoding.dev/images/large/${detailRestaurant.restaurantDetailModel?.restaurant.pictureId}'),
                        // Positioned(
                        //   top: 20,
                        //   right: 20,
                        //   child: IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(Icons.favorite_outline),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
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
                          height: 16,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (detailRestaurant.isFavorite == false) {
                              context.read<DetailProvider>().favoriteTap();
                              var favorite = AddFavorite(
                                restaurantID: detailRestaurant
                                    .restaurantDetailModel?.restaurant.id,
                                location: detailRestaurant
                                    .restaurantDetailModel?.restaurant.city,
                                name: detailRestaurant
                                    .restaurantDetailModel?.restaurant.name,
                                pictureID: detailRestaurant
                                    .restaurantDetailModel
                                    ?.restaurant
                                    .pictureId,
                                rating: detailRestaurant
                                    .restaurantDetailModel?.restaurant.rating,
                              );
                              context
                                  .read<DetailProvider>()
                                  .addFavorite(favorite);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('add to favorite'),
                                  duration: Duration(milliseconds: 800),
                                ),
                              );
                            } else {
                              context.read<DetailProvider>().favoriteTap();
                              context.read<DetailProvider>().removeFavorite(
                                    detailRestaurant
                                        .restaurantDetailModel?.restaurant.id,
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('remove from favorite'),
                                  duration: Duration(milliseconds: 800),
                                ),
                              );
                            }
                          },
                          icon: (detailRestaurant.isFavorite == true)
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_outline),
                          label: const Text('add to favorite'),
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
                        Row(
                          children: const [
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
                        FoodMenu(menu: detailRestaurant.restaurantDetailModel),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: const [
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
                        DrinkMenu(menu: detailRestaurant.restaurantDetailModel),
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
                                builder: (context) => commentSection(),
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
    );
  }

  Widget commentSection() {
    var commentData = context
        .read<DetailProvider>()
        .restaurantDetailModel
        ?.restaurant
        .customerReviews;
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
                key: formKey,
                child: TextFormField(
                  controller: commentInputController,
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
                        var validForm = formKey.currentState!.validate();

                        var restaurantID = widget.restaurantID;
                        var name = userName;
                        var review = commentInputController.text;

                        if (validForm) {
                          context
                              .read<DetailProvider>()
                              .addReview(restaurantID, name, review);

                          Navigator.pop(context);
                          commentInputController.clear();
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
