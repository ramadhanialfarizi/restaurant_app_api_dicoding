import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/model/signin/signin_request_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/model/signin/signin_response_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/view/signup_page.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view/home_pages.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/warning_popup.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/authentication_helpers/auth_helpers.dart';
import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';

class AuthProvider extends ChangeNotifier with CacheManager {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  ResultState? state;

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

  doLogin(context) async {
    final loginValid = formKey.currentState!.validate();

    if (loginValid) {
      state = ResultState.loading;
      notifyListeners();

      SigninRequestModel param = SigninRequestModel()
        ..email = emailController.text
        ..password = passwordController.text;

      SigninResponseModel responseModel =
          await AuthHelpers().loginAccount(param);

      if (responseModel.isError == false) {
        state = ResultState.hasData;
        notifyListeners();

        setLoginStatus(true);
        setEmailName(emailController.text);
        Navigator.of(context).pushReplacementNamed(HomePages.routes);
      } else {
        state = ResultState.noData;
        notifyListeners();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return WarningDialog(
              message: responseModel.errorMsg,
            );
          },
        );
      }
    }
  }

  void goToSignup(context) {
    Navigator.of(context).pushNamed(SignupPage.routes);
  }
}
