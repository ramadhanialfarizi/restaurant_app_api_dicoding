import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app_api_dicoding/app/source/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/view_model/home_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart' as dio;

class MockAPITest extends Mock implements dio.Dio {}

@GenerateMocks([MockAPITest])
void main() {
  var client = MockAPITest();

  group(' test for get List Restaurant API', () {
    test('request list restaurant', () async {
      /// ARANGE
      var homeProvider = HomeProvider();
      //var testModuleName = 'test module';

      /// ACT
      homeProvider.getAllRestaurantList();

      /// ASSERT
      var result = homeProvider.restoList?.restaurants[0].name;
      expect(result, result);
    });

    test('request list restaurant no error', () async {
      var url = 'https://restaurant-api.dicoding.dev/list';
      when(client.get(url)).thenAnswer(
        (_) => Future.value(
          dio.Response(
            statusCode: 200,
            requestOptions: dio.RequestOptions(path: url),
            data: '''{
              "error": false,
              "message": "success",
              "count": 20,
              "restaurants": []
            }''',
          ),
        ),
      );
      var result = await RemoteDataSource().getRestaurantList();
      expect(result, isA<RestaurantListModel>());
    });
  });
}
