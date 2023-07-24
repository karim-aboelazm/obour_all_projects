import 'package:kemet/models/city.dart';
import 'package:kemet/models/place_category.dart';

class Place {
  var id;
  City city;
  PlaceCategory category;

  List<dynamic> gallery;
  var main_Image;
  var name;
  var price;
  var rate;
  var info;
  var location_text;
  bool isfav;

  // Location location;

  Place({
    required this.id,
    required this.city,
    required this.category,
    required this.gallery,
    required this.main_Image,
    required this.name,
    required this.price,
    required this.rate,
    required this.info,
    required this.location_text,
    this.isfav = false,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json["id"],
      city: City.fromJson(json["city"]),
      category: PlaceCategory.fromJson(json["category"]),
      gallery: List.of(json["gallery"]).map((i) => i["image"]).toList(),
      main_Image: json["main_Image"],
      name: json["name"],
      price: json["price"],
      rate: json["rate"],
      info: json["info"],
      location_text: json["location_text"],
      isfav: json['is_user_fav_place'],
    );
  }
//
}
