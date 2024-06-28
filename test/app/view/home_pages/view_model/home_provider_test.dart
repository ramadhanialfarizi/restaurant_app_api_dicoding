import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:restaurant_app_api_dicoding/app/view/home_pages/view_model/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_provider_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  HomeProvider? homeProvider;
  MockSharedPreferences? mockSharedPreferences;

  group(
    'test for home pages',
    () {
      setUp(
        () {
          homeProvider = HomeProvider();
          mockSharedPreferences = MockSharedPreferences();
          SharedPreferences.setMockInitialValues({});
        },
      );
      test(
        'test list restaurant is not empty when get data from api',
        () async {
          await homeProvider?.getAllRestaurantList();

          bool listRestaurantStatus = (homeProvider ?? HomeProvider())
              .restoList!
              .restaurants!
              .isNotEmpty;

          expect(listRestaurantStatus, true);
        },
      );

      // TEST FOR THIS IT'S STILL ERROR
      // test('username is exist when open homepage after login', () async {
      //   String email = "testing@gmail.com";
      //   String password = "testing@123";

      //   // when(mockSharedPreferences?.setString(
      //   //         CacheManagerKey.emailName.name, "testing@gmail.com"))
      //   //     .thenAnswer((_) async => true);

      //   CacheManagerTest().doSetEmail(email, password);

      //   // when(mockSharedPreferences?.getString(
      //   //   CacheManagerKey.emailName.name,
      //   // )).thenReturn("testing@gmail.com");

      //   await homeProvider?.initData();

      //   expect(homeProvider?.userName, "testing@gmail.com");
      // });

      test(
        'username is Not exist when open homepage before login',
        () async {
          await homeProvider?.initData();

          bool userNameNotExist =
              (homeProvider ?? HomeProvider()).userName.isEmpty;

          expect(userNameNotExist, true);
        },
      );
    },
  );
}
