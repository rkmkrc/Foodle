import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodle_app/Model/Restaurant.dart';
import 'package:foodle_app/Reviews/AddReviewPage.dart';
import 'package:get/get.dart';

/* void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MealCardWidget(foodContent: '', price: 44, photo: '', rate: 3, mealName: '',),
    );
  }
} */

class MealCardWidget extends StatefulWidget {
  final Restaurant restaurant;
  final int mealID;
  final String mealName;
  final String? foodContent;
  final double rate;
  final double price;
  final String? photo;
  final String? reviewCount;

  const MealCardWidget(
      {Key? key,
      required this.restaurant,
      required this.mealName,
      required this.foodContent,
      required this.rate,
      required this.price,
      required this.photo,
      this.reviewCount,
      required this.mealID})
      : super(key: key);

  @override
  _MealCardWidgetState createState() => _MealCardWidgetState();
}

class _MealCardWidgetState extends State<MealCardWidget> {
  var imgList = ["food1", "food2", "food3"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.90,
        child: Scaffold(
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade500, width: 1)),
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/${imgList[Random().nextInt(3)]}.png",
                            width: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 210,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.mealName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                              GestureDetector(
                                onTap:(() {
                                  Get.to(() => AddReviewPage(
                                    restaurantName: widget.restaurant.name,
                                    mealName: widget.mealName,
                                    mealID: widget.mealID.toString(),
                                    restaurantLocation: "Beşiktaş"));
                                } ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Add Review",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    Icon(
                                      Icons.add_circle_outline,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.55,
                              maxHeight: 100),
                          child: Text(
                            "",
                            style: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    Text(
                                      widget.rate.toPrecision(2).toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "(${widget.reviewCount} Reviews)",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black),
                              ),
                              Text(
                                "₺${widget.price.toPrecision(2).toString()}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
