import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
    this.username,
    required this.onLogoutPress,
  });

  final String? username;
  final VoidCallback onLogoutPress;

  // SharedPreferences? loginData;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
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
          // ListTile(
          //   title: const Text(
          //     'Your Profile',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 15,
          //     ),
          //   ),
          //   onTap: () {
          //     // Update the state of the app.
          //     Navigator.of(context).pushNamed('/profile');
          //   },
          // ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
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
        ],
      ),
    );
  }
}
