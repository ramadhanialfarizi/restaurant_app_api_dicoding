import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/model/signin/signin_request_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/model/signin/signin_response_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/model/signup/signup_request_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/authentication/model/signup/signup_response_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/authlogout_response_model.dart';

class AuthHelpers {
  Future<SignupResponseModel> registerAccount(
      SignupRequestModel? requestParam) async {
    SignupResponseModel responseModel = SignupResponseModel();
    if (requestParam != null) {
      try {
        UserCredential? registerAcc =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: requestParam.email ?? "",
          password: requestParam.password ?? "",
        );

        // ignore: unnecessary_null_comparison
        if (registerAcc != null) {
          responseModel.isError = false;
          responseModel.errorMsg = "";
        } else {
          responseModel.isError = true;
          responseModel.errorMsg = "register failed, please try again";
        }
        return responseModel;
      } on FirebaseAuthException catch (e) {
        responseModel.isError = true;
        responseModel.errorMsg = e.toString();

        return responseModel;
      }
    } else {
      return SignupResponseModel(
        isError: true,
        errorMsg: "request is empty, please input again",
      );
    }
  }

  Future<SigninResponseModel> loginAccount(
      SigninRequestModel? requestParam) async {
    SigninResponseModel responseModel = SigninResponseModel();

    if (requestParam != null) {
      try {
        UserCredential? userLoginCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: requestParam.email ?? "",
          password: requestParam.password ?? "",
        );

        // ignore: unnecessary_null_comparison
        if (userLoginCredential != null) {
          responseModel.isError = false;
          responseModel.errorMsg = "";
        } else {
          responseModel.isError = true;
          responseModel.errorMsg = "register failed, please try again";
        }
        return responseModel;
      } on FirebaseAuthException catch (e) {
        responseModel.isError = true;
        responseModel.errorMsg = e.toString();

        return responseModel;
      }
    } else {
      responseModel
        ..isError = true
        ..errorMsg = "request is empty, please input again";

      return responseModel;
    }
  }

  Future<AuthlogoutResponseModel> logout() async {
    AuthlogoutResponseModel responseModel = AuthlogoutResponseModel();
    try {
      await FirebaseAuth.instance.signOut();

      responseModel.isError = false;
      responseModel.errorMsg = "";

      return responseModel;
    } on FirebaseAuthException catch (e) {
      responseModel.isError = true;
      responseModel.errorMsg = e.toString();

      return responseModel;
    }
  }
}
