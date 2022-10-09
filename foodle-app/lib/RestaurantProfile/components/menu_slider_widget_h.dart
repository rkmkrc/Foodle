import 'package:flutter/material.dart';
import 'package:foodle_app/HttpService/Restaurant/restaurantServices.dart';
import 'package:foodle_app/Menu/MenuPage.dart';
import 'package:foodle_app/Model/Meal.dart';
import 'package:foodle_app/Model/Restaurant.dart';
import 'package:foodle_app/RestaurantProfile/components/meal_card_widget.dart';
import 'package:get/get.dart';

class MenuSliderWidget_H extends StatelessWidget {
  final Restaurant restaurant;
  const MenuSliderWidget_H({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var json = restaurant.mealsOfRestaurant as List;
    var mealList = json.map((data) => Meal.fromJson(data))
      .toList();
     

    
          
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: const Text(
                        "Menu",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      onTap: () {
                        Get.to(MenuPage(restaurant: restaurant, mealList: mealList,));
                      },
                    ),
                    GestureDetector(
                      child: Text(
                        "(see all)",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Colors.black),
                      ),
                      onTap: () {
                        Get.to(MenuPage(restaurant: restaurant, mealList: mealList,));
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: mealList.map((i) =>  MealCardWidget(
                    restaurant:restaurant,
                      mealID: i.mealID,
                      mealName: i.name,
                        foodContent: i.foodContent,
                        photo: '',
                        rate: i.rate,
                        price: i.price,
                        reviewCount: i.reviewCount,
                    )).toList()
                  ),
                ),
              ),
            ],
          );
        
  }
}
