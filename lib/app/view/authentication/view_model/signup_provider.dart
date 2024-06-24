import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

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

  void doRegister() async {
    final loginValid = formKey.currentState!.validate();

    if (loginValid) {}
  }
}
