import 'package:restaurant_app_api_dicoding/core/utils/cache_manager.dart';

class CacheManagerTest with CacheManager {
  // FOR UNIT TEST FUNCTION
  doSetEmail(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      setEmailName(email);
    }
  }
}
