import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodle_app/HttpService/User/userServices.dart';
import 'package:foodle_app/RestaurantProfile/RestaurantProfilePage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> addReview(String rate, String review, String mealID, String image,BuildContext context) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  //String photo = encodePhotoToBase64(image).toString();
  String userName = ""; // Implement later
  var url = Uri.parse('http://172.16.3.237:3000/restaurant/review/add');
  var response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": accessToken,
        "CurrentUserID": userID,
      },
      body: JsonEncoder().convert({
        "rate": rate,
        "text": review,
        "userID": userID, // {{CurrentUserID}}
        "mealID": mealID,
        "photos": []
      }));
  if (response.statusCode == 200) {
    print("-------------addReview SUCCESS--------------");
    Get.back();
  } else {
    print("-------------addReview UNSUCCESS--------------");
  }
  print("RAte in HTTP = == " + rate);
  print(response.body);
}

Future<void> deleteReview(String reviewID) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  String userName = ""; // Implement later
  var url = Uri.parse(
      'http://172.16.3.237:3000/restaurant/review/delete?reviewID=$reviewID');
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------deleteReview SUCCESS--------------");
  } else {
    print("-------------deleteReview UNSUCCESS--------------");
  }

  print(response.body);
}

Future<void> voteReview(String reviewID) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  String userName = ""; // Implement later
  var url = Uri.parse(
      'http://172.16.3.237:3000/restaurant/review/vote?reviewID=$reviewID&action=delete');
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------voteRev SUCCESS--------------");
  } else {
    print("-------------voteRev UNSUCCESS--------------");
  }

  print(response.body);
}

Future<void> getMealReview(String mealID) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  String userName = ""; // Implement later
  var url =
      Uri.parse('http://172.16.3.237:3000/restaurant/review?mealID=$mealID');
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------getMealReview SUCCESS--------------");
  } else {
    print("-------------getMealReview UNSUCCESS--------------");
  }

  print(response.body);
}

Future<void> getRestaurantReviews(String restaurantID) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  String userName = ""; // Implement later
  var url = Uri.parse(
      'http://172.16.3.237:3000/restaurant/review?restaurantID=$restaurantID');
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------getRestaurantReviews SUCCESS--------------");
  } else {
    print("-------------getRestaurantReviews UNSUCCESS--------------");
  }
   final String res = response.body;
   final parsed = json.decode(res);
   return parsed; 
  //print(response.body);
}

Future<void> getReview(String reviewID) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  String userName = ""; // Implement later
  var url = Uri.parse(
      'http://172.16.3.237:3000/restaurant/review?reviewID=$reviewID');
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------getReview SUCCESS--------------");
  } else {
    print("-------------getReview UNSUCCESS--------------");
  }

  print(response.body);
}

Future<void> getReviewPhoto(String reviewID) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accessToken").toString();
  String userName = ""; // Implement later
  var url = Uri.parse('http://172.16.3.237:3000/reviews/$reviewID/1.jpg');
  var response = await http.get(
    url,
  );
  if (response.statusCode == 200) {
    print("-------------getReviewPhoto SUCCESS--------------");
  } else {
    print("-------------getReviewPhoto UNSUCCESS--------------");
  }

  print(response.body);
}
