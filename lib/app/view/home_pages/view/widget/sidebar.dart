import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
    this.username,
    required this.onLogoutPress,
    required this.onFavoritePress,
    required this.onHomePress,
    this.screenKey,
    required this.onSettingsPress,
  });

  final String? username;
  final String? screenKey;
  final VoidCallback onLogoutPress;
  final VoidCallback onFavoritePress;
  final VoidCallback onHomePress;
  final VoidCallback onSettingsPress;

  // SharedPreferences? loginData;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: ColorsConstant.primaryColors,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: screenKey == ScreenKey.homeScreen.name
                            ? Colors.grey
                            : Colors.black),
                  ),
                  onTap: onHomePress,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.favorite,
                    color: ColorsConstant.secondaryColors,
                  ),
                  title: Text(
                    'Favorites',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: screenKey == ScreenKey.favoriteScreen.name
                            ? Colors.grey
                            : Colors.black),
                  ),
                  onTap: onFavoritePress,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: ColorsConstant.thirdColors,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: screenKey == ScreenKey.settingsScreen.name
                            ? Colors.grey
                            : Colors.black),
                  ),
                  onTap: onSettingsPress,
                ),
              ],
            ),
          ),
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Welcome...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // USER EMAIL
            accountEmail: Text(
              username ?? "empty",
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/sidebar_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.account_circle, color: Colors.white),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    ColorsConstant.primaryColors,
                  ),
                ),
                // onPressed: () async {
                //   // loginData!.setBool('login', false);
                //   // loginData!.remove('userName');

                //   // Navigator.of(context).pushReplacementNamed('/signin');
                // },
                onPressed: onLogoutPress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
