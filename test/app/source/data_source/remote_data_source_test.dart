import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app_api_dicoding/app/source/data_source/remote_data_source.dart';
import 'package:restaurant_app_api_dicoding/app/view/detail_pages/model/restaurant_detail_model.dart';
import 'package:restaurant_app_api_dicoding/app/view/home_pages/model/restaurant_list_model.dart';

import 'package:dio/dio.dart' as dio;
import 'package:restaurant_app_api_dicoding/app/view/search_pages/model/restaurant_search_model.dart';

import 'remote_data_source_test.mocks.dart';

@GenerateMocks([dio.Dio])
void main() {
  var _baseUrl = 'https://restaurant-api.dicoding.dev';
  RemoteDataSource? dataSource;
  MockDio? mockdio;
  group(
    'test RemoteDataSource class for getRestaurantList',
    () {
      setUp(
        () {
          dataSource = RemoteDataSource();
          mockdio = MockDio();
        },
      );

      test(
        "test for hit api for getRestaurantList",
        () async {
          final response = Response(
            data: {
              "error": false,
              "message": "success",
              "count": 20,
              "restaurants": [
                {
                  "id": "rqdv5juczeskfw1e867",
                  "name": "Melting Pot",
                  "description":
                      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
                  "pictureId": "14",
                  "city": "Medan",
                  "rating": 4.2
                },
                {
                  "id": "s1knt6za9kkfw1e867",
                  "name": "Kafe Kita",
                  "description":
                      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
                  "pictureId": "25",
                  "city": "Gorontalo",
                  "rating": 4
                }
              ]
            },
            statusCode: 200,
            requestOptions: RequestOptions(path: '$_baseUrl/list'),
          );

          when(mockdio?.get('$_baseUrl/list')).thenAnswer(
            (realInvocation) async {
              return response;
            },
          );

          final result = await mockdio?.get('$_baseUrl/list');

          expect(result?.data, response.data);
        },
      );
      test(
        'Test data for function getRestaurantList is return RestaurantListModel ',
        () async {
          var source = await dataSource?.getRestaurantList();

          expect(source, isA<RestaurantListModel>());
        },
      );
    },
  );

  group(
    'test RemoteDataSource class for getDetailRestaurant',
    () {
      String id = 'rqdv5juczeskfw1e867';
      setUp(
        () {
          dataSource = RemoteDataSource();
          mockdio = MockDio();
        },
      );

      test(
        'test hit api Get Detail of Restaurant',
        () async {
          final response = Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: '$_baseUrl/detail/$id'),
            data: {
              "error": false,
              "message": "success",
              "restaurant": {
                "id": "rqdv5juczeskfw1e867",
                "name": "Melting Pot",
                "description":
                    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                "city": "Medan",
                "address": "Jln. Pandeglang no 19",
                "pictureId": "14",
                "categories": [
                  {"name": "Italia"},
                  {"name": "Modern"}
                ],
                "menus": {
                  "foods": [
                    {"name": "Paket rosemary"},
                    {"name": "Toastie salmon"}
                  ],
                  "drinks": [
                    {"name": "Es krim"},
                    {"name": "Sirup"}
                  ]
                },
                "rating": 4.2,
                "customerReviews": [
                  {
                    "name": "Ahmad",
                    "review": "Tidak rekomendasi untuk pelajar!",
                    "date": "13 November 2019"
                  }
                ]
              }
            },
          );

          when(mockdio?.get('$_baseUrl/detail/$id')).thenAnswer(
            (realInvocation) async {
              return response;
            },
          );

          final result = await mockdio?.get('$_baseUrl/detail/$id');

          expect(result?.data, response.data);
        },
      );

      test(
        'Test data for function getDetailRestaurant is return RestaurantDetailModel ',
        () async {
          var source = await dataSource?.getDetailRestaurant(id);

          expect(source, isA<RestaurantDetailModel>());
        },
      );
    },
  );

  group(
    'test RemoteDataSource class for getRestaurantSearch',
    () {
      String search = 'Makan mudah';
      setUp(
        () {
          dataSource = RemoteDataSource();
          mockdio = MockDio();
        },
      );

      test(
        'test hit api restaurant search endpoint',
        () async {
          String path = '$_baseUrl/search?q=$search';
          final response = Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
            data: {
              "error": false,
              "founded": 1,
              "restaurants": [
                {
                  "id": "fnfn8mytkpmkfw1e867",
                  "name": "Makan mudah",
                  "description":
                      "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
                  "pictureId": "22",
                  "city": "Medan",
                  "rating": 3.7
                }
              ]
            },
          );

          when(mockdio?.get(path)).thenAnswer(
            (realInvocation) async {
              return response;
            },
          );

          final result = await mockdio?.get(path);

          expect(result?.data, response.data);
        },
      );

      test(
        'Test data for function getDetailRestaurant is return RestaurantDetailModel ',
        () async {
          var source = await dataSource?.getRestaurantSearch(search);

          expect(source, isA<SearchRestaurantModel>());
        },
      );
    },
  );
}
