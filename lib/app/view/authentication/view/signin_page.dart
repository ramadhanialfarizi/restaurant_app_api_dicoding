import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view_model/auth_provider.dart';
import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';
import 'package:restaurant_app_api_dicoding/core/utils/image_constant.dart';

class SigninPages extends StatelessWidget {
  const SigninPages({super.key});
  static const String routes = "/signin";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const _SigninBuilder(),
    );
  }
}

class _SigninBuilder extends StatelessWidget {
  const _SigninBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.read<AuthProvider>();
    return BaseWidgetContainer(
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
                  ImagesConstant.icons,
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
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          hintText: 'input your email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* please input your email';
                          }

                          if (!value.contains("@")) {
                            return '* please input valid email';
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
                            controller: controller.passwordController,
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
                            backgroundColor: WidgetStateProperty.all<Color>(
                              ColorsConstant.primaryColors,
                            ),
                          ),
                          onPressed: () async {
                            controller.doLogin(context);
                            // final loginValid = formKey.currentState!.validate();

                            // String email = emailController.text;

                            // if (loginValid) {
                            //   loginUser!.setBool('login', true);
                            //   loginUser!.setString('userName', email);
                            //   Navigator.of(context)
                            //       .pushReplacementNamed(HomePages.routes);
                            // }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Tidak memiliki akun?"),
                    TextButton(
                      onPressed: () =>
                          context.read<AuthProvider>().goToSignup(context),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: ColorsConstant.primaryColors),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
