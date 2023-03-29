class AddFavorite {
  int? id;
  String? restaurantID;
  String? pictureID;
  String? name;
  String? location;
  double? rating;

  AddFavorite({
    this.id,
    this.restaurantID,
    this.pictureID,
    this.name,
    this.location,
    this.rating,
  });

  factory AddFavorite.fromMap(Map<String, dynamic> map) {
    return AddFavorite(
      id: map['id'],
      restaurantID: map['restaurantID'],
      pictureID: map['pictureID'],
      name: map['name'],
      location: map['location'],
      rating: map['rating'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantID': restaurantID,
      'pictureID': pictureID,
      'name': name,
      'location': location,
      'rating': rating,
    };
  }
}
