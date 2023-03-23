import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view_model/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninPages extends StatefulWidget {
  const SigninPages({super.key});

  @override
  State<SigninPages> createState() => _SigninPagesState();
}

class _SigninPagesState extends State<SigninPages> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SharedPreferences? loginUser;
  bool? user;

  void checkLogin(context) async {
    loginUser = await SharedPreferences.getInstance();
    user = loginUser?.getBool('login') ?? false;

    if (user == true) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin(context);
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              right: 25,
              left: 25,
              top: 100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/splash_screen_icon.png',
                  scale: 3,
                ),
                const SizedBox(
                  height: 19,
                ),
                const Text(
                  'Hi, Selamat Datang kembali :)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 45,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          hintText: 'input your username',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* please input your username';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, value, _) {
                          return TextFormField(
                            controller: passwordController,
                            obscureText: value.obscurePassword,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: InkWell(
                                onTap: () => context
                                    .read<AuthProvider>()
                                    .changeObscurePassword(),
                                child: value.obscurePassword
                                    ? const Icon(Icons.remove_red_eye_outlined)
                                    : const Icon(Icons.remove_red_eye),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* please input your Password';
                              } else if (value.length < 8) {
                                return '* Password must be have a 8 character';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.account_circle,
                              color: Colors.white),
                          label: const Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF44bcd8),
                            ),
                          ),
                          onPressed: () async {
                            final loginValid = formKey.currentState!.validate();

                            String userName = userNameController.text;

                            if (loginValid) {
                              loginUser!.setBool('login', true);
                              loginUser!.setString('userName', userName);
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
