import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';
import 'package:restaurant_app_api_dicoding/main.dart';

mixin CacheManager {
  Future<void> setLoginStatus(bool status) async {
    await sharedPreferences?.setBool(
        CacheManagerKey.loginSaveData.name, status);
  }

  Future<void> setEmailName(String email) async {
    if (email.isNotEmpty) {
      await sharedPreferences?.setString(CacheManagerKey.emailName.name, email);
    }
  }

  Future<bool> getLoginStatus() async {
    bool loginStatus =
        sharedPreferences?.getBool(CacheManagerKey.loginSaveData.name) ?? false;
    return loginStatus;
  }

  Future<String> getEmailName() async {
    String emailName =
        sharedPreferences?.getString(CacheManagerKey.emailName.name) ?? "";
    return emailName;
  }

  Future<void> removeData({required String keyType}) async {
    if (keyType == CacheManagerKey.emailName.name) {
      await sharedPreferences?.remove(CacheManagerKey.emailName.name);
    }
    if (keyType == CacheManagerKey.loginSaveData.name) {
      await sharedPreferences?.remove(CacheManagerKey.loginSaveData.name);
    }
  }

  Future<void> setProcessStatus({required bool status}) async {
    await sharedPreferences?.setBool(
        CacheManagerKey.setProcessStatus.name, status);
  }

  Future<bool> getProcessStatus() async {
    bool processStatus =
        sharedPreferences?.getBool(CacheManagerKey.setProcessStatus.name) ??
            false;
    return processStatus;
  }

  Future<void> setNeedRefresh({required bool status}) async {
    await sharedPreferences?.setBool(
        CacheManagerKey.setNeedRefresh.name, status);
  }

  Future<bool> getNeedRefresh() async {
    bool needRefresh =
        sharedPreferences?.getBool(CacheManagerKey.setNeedRefresh.name) ??
            false;
    return needRefresh;
  }
}
