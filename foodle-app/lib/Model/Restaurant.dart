import 'package:foodle_app/Model/Meal.dart';

class Restaurant {
  late int restaurantID;
  late String name;
  late String type;
  late double rate;
  late double latitude;
  late double longitude;
  late String? photos;
  late String? reviewCount;
  late Object mealsOfRestaurant;

  Restaurant(this.restaurantID, this.name, this.type, this.rate, this.latitude,
      this.longitude, this.photos, this.reviewCount,this.mealsOfRestaurant); //;
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

  factory Restaurant.fromJson(Map<String, dynamic> json){
    return Restaurant( 
      json["restaurantInfo"]['restaurantid'],
        json["restaurantInfo"]["name"],
        json["restaurantInfo"]["type"],
        json["restaurantInfo"]["rate"]+.0,
        json["restaurantInfo"]["latitude"],
        json["restaurantInfo"]["longitude"],
        json["restaurantInfo"]["photos"],
        json["restaurantInfo"]["reviewcount"],
        json["meals"],
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
