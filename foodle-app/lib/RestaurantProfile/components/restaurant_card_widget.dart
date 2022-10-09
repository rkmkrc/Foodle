import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodle_app/Model/GetRestaurants.dart';
import 'package:foodle_app/Model/Restaurant.dart';
import 'package:foodle_app/RestaurantProfile/RestaurantProfilePage.dart';
import 'package:get/get.dart';

/* void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: RestaurantCardWidget(name: "Carrows Restaurant", location: "Kadıköy", imgPath: "rest_logo1.png",),
    );
  }
} */

class RestaurantCardWidget extends StatefulWidget {
  final GetRestaurants restaurant;
  const RestaurantCardWidget({Key? key, required this.restaurant}) : super(key: key);

  @override
  _RestaurantCardWidgetState createState() => _RestaurantCardWidgetState();
}

class _RestaurantCardWidgetState extends State<RestaurantCardWidget> {
  @override
  Widget build(BuildContext context) {
    var imgPathList = ["rest1.png", "rest3.png", "rest3.png"];
    var random;
    return GestureDetector(
      onTap: (){Get.to(() => RestaurantProfilePage(restaurant: widget.restaurant,));},
      child: Padding(
        padding: EdgeInsets.all(4.0),
        
           child: SizedBox(
            height: 200,
            width: 230,
            child: Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade200,
                      ),
                      child:
                          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                              height: 100,
                              width: 980,
                              margin: EdgeInsets.symmetric(horizontal: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                child: Image.asset(
                                  "assets/images/" + imgPathList[Random().nextInt(3)],
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ),
                            SizedBox(height: 8,),
                         Text(
                          widget.restaurant.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar.builder(
                                itemSize: 12,
                                initialRating: widget.restaurant.rate,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(
                                  horizontal: 2.0,
                                ),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              
                              Row(
                                children:  [
                                  Icon(
                                    Icons.set_meal_outlined,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    widget.restaurant.type,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
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
