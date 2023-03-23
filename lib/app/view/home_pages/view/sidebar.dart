import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  SharedPreferences? loginData;
  String userName = " ";

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      userName = loginData!.getString('userName').toString();
    });
  }

  @override
  void initState() {
    initial();
    super.initState();
  }

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
              userName,
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
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF76b5c5),
                ),
              ),
              onPressed: () async {
                loginData!.setBool('login', false);
                loginData!.remove('userName');

                Navigator.of(context).pushReplacementNamed('/signin');
              },
            ),
          ),
        ],
      ),
    );
  }
}
