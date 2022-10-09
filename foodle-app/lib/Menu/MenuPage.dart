import 'package:flutter/material.dart';
import 'package:foodle_app/Model/Meal.dart';
import 'package:foodle_app/Model/Restaurant.dart';
import 'package:foodle_app/RestaurantProfile/components/meal_card_widget.dart';
import 'package:foodle_app/RestaurantProfile/components/restaurant_badge_widget.dart';
import 'package:get/get.dart';

/* void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
} */

class MenuPage extends StatefulWidget {
  final Restaurant restaurant;
  final List<Meal> mealList;
  const MenuPage({Key? key, required this.restaurant,required this.mealList}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 20,
            color: Colors.grey.shade800,
          ),
          RestaurantBadgeWidget(
            rate: widget.restaurant.rate.toPrecision(2),
            restaurantName: widget.restaurant.name,
            type: widget.restaurant.type,
            reviewCount: widget.restaurant.reviewCount,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(8, 2, 8, 4),
                child: Text(
                  "Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: SizedBox(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.mealList.map((i) =>  MealCardWidget(
                        restaurant: widget.restaurant,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
