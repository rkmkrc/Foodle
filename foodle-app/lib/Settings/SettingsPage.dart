import 'package:flutter/material.dart';
import 'package:foodle_app/HttpService/Auth/authServices.dart';
import 'package:foodle_app/HttpService/Restaurant/restaurantServices.dart';
import 'package:foodle_app/HttpService/http_request.dart';
import 'package:foodle_app/Model/Meal.dart';
import 'package:foodle_app/Model/Restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(height: 300,),
          ElevatedButton(
            child: Text("Logout"),
            onPressed: () {
              setState(() {
                sendLogoutRequest();
              });
            },
          ),
          /* ElevatedButton(
            child: Text("Get"),
            onPressed: () async{
              var sharedPreferences = await SharedPreferences.getInstance();
                String userID = sharedPreferences.getInt("userID").toString();
                String accessToken =
                    sharedPreferences.getString("accessToken").toString();
                print("accTokInBUTTON====" +
                    accessToken);
                  print("userIDInBUTTON====" +
                    userID);
                   // Restaurant restaurant = Restaurant(1, "name", "type", 2, 2, 2, "photos");
           
                 var x = await getARestaurant(70);
                
                //print("ALDIK = " + restaurant.name.toString());
           //     print("ALDIK => " + x.name.toString());
                
              setState(() {
                /* Meal meal = Meal(mealID: 1, restaurantID: 1, price: 1, rate: 1, name: "İLK");
                var response = getAMeal(2761);
                print("-----------------------------------------");
                print(response); */
                ;
              });
            },
          ), */
        ],
      )),
    );
  }
}
