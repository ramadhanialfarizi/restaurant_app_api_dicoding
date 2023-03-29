import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/favorite/view_model/favorite_provider.dart';

import '../../../../core/global_widget/sidebar.dart';

class FavoritePages extends StatefulWidget {
  const FavoritePages({super.key});

  @override
  State<FavoritePages> createState() => _FavoritePagesState();
}

class _FavoritePagesState extends State<FavoritePages> {
  @override
  void initState() {
    // TODO: implement initState
    getFavoriteList();
    super.initState();
  }

  void getFavoriteList() {
    context.read<FavoriteProvider>().getAllFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                  'Favorite',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Consumer<FavoriteProvider>(
                  builder: (context, favoriteProv, __) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      //itemCount: restaurant.restoList?.restaurants.length,
                      itemCount: favoriteProv.favorite.length,
                      itemBuilder: (context, index) {
                        var initial = favoriteProv.favorite[index];
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
                                      'https://restaurant-api.dicoding.dev/images/medium/${initial.pictureID}',
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
                                          '${initial.name}',
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
                                            Text('${initial.location}'),
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
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.delete),
                                          label: const Text('remove'),
                                          onPressed: () {
                                            context
                                                .read<FavoriteProvider>()
                                                .deleteNote(initial.id);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'remove from favorite'),
                                                duration:
                                                    Duration(milliseconds: 800),
                                              ),
                                            );
                                          },
                                        ),
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
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
