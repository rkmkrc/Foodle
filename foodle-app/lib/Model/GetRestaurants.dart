import 'package:foodle_app/Model/Meal.dart';

class GetRestaurants {
  late int restaurantID;
  late String name;
  late String type;
  late double rate;
  late double latitude;
  late double longitude;
  late String? photos;
  late String? reviewCount;

  GetRestaurants(this.restaurantID, this.name, this.type, this.rate, this.latitude,
      this.longitude, this.photos, this.reviewCount); //;
/* 
  Restaurant.fromJson(Map<String, dynamic> json)
      : restaurantID = json["restaurantInfo"]['restaurantid'],
        name = json["restaurantInfo"]["name"],
        type = json["restaurantInfo"]["type"],
        rate = json["restaurantInfo"]["rate"],
        latitude = json["restaurantInfo"]["latitude"],
        longitude = json["restaurantInfo"]["longitude"],
        photos = json["restaurantInfo"]["photos"],
        reviewCount = json["restaurantInfo"]["reviewcount"]; */

  factory GetRestaurants.fromJson(Map<String, dynamic> json){
    return GetRestaurants( 
      json['restaurantid'],
        json["name"],
        json["type"],
        json["rate"]+.0,
        json["latitude"]+.0,
        json["longitude"]+.0,
        json["photos"],
        json["reviewcount"],
       
    );
  }

  /* "restaurantInfo": {
        "restaurantid": 72,
        "name": "Escape Café",
        "type": "Toast & Sandwich",
        "rate": 2.335714285714286,
        "latitude": 41.05736,
        "longitude": 29.319033,
        "photos": null
    }, */

}
