import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view_model/signup_provider.dart';
import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';
import 'package:restaurant_app_api_dicoding/core/utils/image_constant.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  static const String routes = "/signup";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignupProvider(),
      child: const _SignupLayoutBuilder(),
    );
  }
}

class _SignupLayoutBuilder extends StatelessWidget {
  const _SignupLayoutBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.read<SignupProvider>();
    return BaseWidgetContainer(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
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
                  'Hi, Silahkan daftarkan akun kamu :)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 45,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.firstNameController,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* please input your first name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: controller.lastNameController,
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* please input your last name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                      Consumer<SignupProvider>(
                        builder: (context, value, _) {
                          return TextFormField(
                            controller: controller.passwordController,
                            obscureText: value.obscurePassword,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: InkWell(
                                onTap: () => controller.changeObscurePassword(),
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
                        height: 15,
                      ),
                      Consumer<SignupProvider>(
                        builder: (context, value, _) {
                          return TextFormField(
                            controller: controller.confirmPasswordController,
                            obscureText: value.obscureConfirmPassword,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              suffixIcon: InkWell(
                                onTap: () =>
                                    controller.changeConfirmObscurePassword(),
                                child: value.obscureConfirmPassword
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.account_circle, color: Colors.white),
                    label: const Text(
                      'Register',
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
                      controller.doRegister();
                    },
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sudah memiliki akun?"),
                    TextButton(
                      onPressed: () => controller.goToSignin(context),
                      child: const Text(
                        "Login",
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
