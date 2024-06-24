import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view/signup_page.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view/home_pages.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';

class AuthProvider extends ChangeNotifier with CacheManager {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  doLogin(context) {
    final loginValid = formKey.currentState!.validate();

    if (loginValid) {
      setLoginStatus(true);
      setEmailName(emailController.text);
      Navigator.of(context).pushReplacementNamed(HomePages.routes);
    }
  }

  void goToSignup(context) {
    Navigator.of(context).pushNamed(SignupPage.routes);
  }
}
