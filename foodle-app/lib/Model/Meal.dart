import 'package:foodle_app/Model/Restaurant.dart';

class Meal {
  late int mealID ;
  late int restaurantID;
  late String name = "";
  late String? description = "";
  late String? foodContent = "";
  late double price;
  late double rate;
  late String? photos = "";
  late String? reviewCount;

  Meal(this.mealID, this.restaurantID, this.description, this.foodContent, this.name, this.photos, this.price,this.rate, this.reviewCount);

  Meal.fromJson(Map<String, dynamic> json)
      : mealID = json['mealid'],
        restaurantID = json['restaurantid'],
        name = json['name'],
        description= json['description'],
        foodContent = json['foodcontent'],
        price =  json['price']+.0,
        rate =  json['rate']+.0,
        photos = json["photos"],
        reviewCount = json["reviewcount"];


}
