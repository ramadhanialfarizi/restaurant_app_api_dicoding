import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app_api_dicoding/app/view/search_pages/view_model/search_provider.dart';

void main() {
  SearchProvider? searchProvider;

  setUp(
    () {
      searchProvider = SearchProvider();
    },
  );

  group(
    'test search data',
    () {
      test(
        "test if search success, list data not empty",
        () async {
          String search = 'Makan mudah';

          searchProvider?.searchInputController.text = search;

          await searchProvider?.getSearchListRestaurant();

          bool listNotempty = (searchProvider ?? SearchProvider())
              .searchRestaurantModel!
              .restaurants!
              .isNotEmpty;

          expect(listNotempty, true);
        },
      );

      test(
        "test if search fail, list data is empty",
        () async {
          String search = 'aaaaa';

          searchProvider?.searchInputController.text = search;

          await searchProvider?.getSearchListRestaurant();

          bool listEmpty = (searchProvider ?? SearchProvider())
              .searchRestaurantModel!
              .restaurants!
              .isEmpty;

          expect(listEmpty, true);
        },
      );
    },
  );
}
