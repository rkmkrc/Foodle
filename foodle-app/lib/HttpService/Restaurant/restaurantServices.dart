import 'dart:convert';
import 'package:foodle_app/HttpService/User/userServices.dart';
import 'package:foodle_app/Model/Meal.dart';
import 'package:foodle_app/Model/Restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> getRestaurants(latitude, longitude, restaurantRate, restaurantType,
    restaurantName, mealRate, mealPrice, mealName) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  String userName = ""; // Implement later
  var url = Uri.parse('http://172.16.3.237:3000/restaurant/get');
  var response = await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": accessToken,
        "CurrentUserID": userID,
      },
      );
  if (response.statusCode == 200) {
    print("-------------getRestaurants SUCCESS--------------");
  } else {
    print("-------------getRestaurants UNSUCCESS--------------");
  }
   final String res = response.body;
  final parsed = json.decode(res);
  return parsed;
  print(response.body);
}

Future <Map<String,dynamic>> getARestaurant(restaurantID) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  String userName = ""; // Implement later
  var url = Uri.parse(
      'http://172.16.3.237:3000/restaurant?restaurantID=$restaurantID');
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------getARestaurant SUCCESS--------------");
  } else {
    print("-------------getARestaurant UNSUCCESS--------------");
  }
  final String res = response.body;
  final parsed = json.decode(res);
  return parsed;
  ///restaurant = Restaurant.fromJson(parsed);
  //return new Restaurant.fromJson(parsed);

  /* print(parsed["restaurantInfo"]["name"]);
  print(restaurant.type.toString());
  print(restaurant.latitude.toString()); */
}

Future<void> getMealsOfARestaurant(restaurantID) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  String userName = ""; // Implement later
  var url = Uri.parse(
      'http://172.16.3.237:3000/restaurant/meals?restaurantID=$restaurantID');
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------getMealsOfARestaurant SUCCESS--------------");
  } else {
    print("-------------getMealsOfARestaurant UNSUCCESS--------------");
  }
  final String res = response.body;
  final parsed = json.decode(res);
  return parsed; 

  print(response.body);
}

Future<Map<String, dynamic>> getAMeal(mealID) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  String userName = ""; // Implement later
  var url =
      Uri.parse('http://172.16.3.237:3000/restaurant/meal?mealID=$mealID');
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------getAMeal SUCCESS--------------");
  } else {
    print("-------------getAMeal UNSUCCESS--------------");
  }
  final String res = response.body;
  final parsed = json.decode(res);
  return parsed;
  /* print(
    json[0]["name"] + json[0]["restaurantid"].toString(),
  ); */
}
