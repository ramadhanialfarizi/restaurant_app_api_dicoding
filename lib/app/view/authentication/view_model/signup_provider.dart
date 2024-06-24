import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/model/signup/signup_request_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/model/signup/signup_response_model.dart';
import 'package:restaurant_app_api_dicoding/core/global_widget/warning_popup.dart';
import 'package:restaurant_app_api_dicoding/core/helpers/authentication_helpers/auth_helpers.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';

class SignupProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  ResultState? state;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void changeConfirmObscurePassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  void goToSignin(context) {
    Navigator.pop(context);
  }

  void doRegister(context) async {
    final loginValid = formKey.currentState!.validate();

    if (loginValid) {
      state = ResultState.loading;
      notifyListeners();

      SignupRequestModel reqParam = SignupRequestModel()
        ..email = emailController.text
        ..firstName = firstNameController.text
        ..lastName = lastNameController.text
        ..password = passwordController.text;

      SignupResponseModel responseModel =
          await AuthHelpers().registerAccount(reqParam);

      if (responseModel.isError == false) {
        state = ResultState.hasData;
        notifyListeners();
        Navigator.pop(context);
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
}
