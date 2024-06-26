class SearchRestaurantModel {
  SearchRestaurantModel({
    this.error,
    this.founded,
    this.restaurants,
  });

  bool? error;
  int? founded;
  List<RestaurantSearchData>? restaurants;

  factory SearchRestaurantModel.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantSearchData>.from(
            json["restaurants"].map((x) => RestaurantSearchData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

class RestaurantSearchData {
  RestaurantSearchData({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  factory RestaurantSearchData.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
