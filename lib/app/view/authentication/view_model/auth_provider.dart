import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool obscurePassword = true;

  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}
