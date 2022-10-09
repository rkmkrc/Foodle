import 'package:flutter/material.dart';
import 'package:foodle_app/HttpService/Restaurant/restaurantServices.dart';
import 'package:foodle_app/Model/GetRestaurants.dart';
import 'package:foodle_app/Model/Restaurant.dart';
import 'package:foodle_app/RestaurantProfile/components/menu_slider_widget_h.dart';
import 'package:foodle_app/RestaurantProfile/components/resturant_image_carousel_widget.dart';
import 'package:foodle_app/RestaurantProfile/components/reviews_silder_widget_v.dart';
import 'package:get/get.dart';
import 'components/restaurant_badge_widget.dart';

/* void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: RestaurantProfilePage(),
    );
  }
} */

class RestaurantProfilePage extends StatefulWidget {
  final GetRestaurants restaurant;
  const RestaurantProfilePage({Key? key, required this.restaurant}) : super(key: key);

  @override
  _RestaurantProfilePageState createState() => _RestaurantProfilePageState();
}

class _RestaurantProfilePageState extends State<RestaurantProfilePage> {
  @override
  Widget build(BuildContext context) {
    var imgPaths = [
      "assets/images/rest3.png",
      "assets/images/rest2.png",
      "assets/images/rest1.png"
    ];

    return FutureBuilder(
      
        future: getARestaurant(widget.restaurant.restaurantID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            final json = snapshot.data as Map<String, dynamic>;
            var restaurant = Restaurant.fromJson(json);
            print("OoOooooooooooooooooooooo");
            print("----");
            print(restaurant.mealsOfRestaurant);
            print("----");
            print("OoOooooooooooooooooooooo");
            return Scaffold(
              //appBar: buildAppBar(context),
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  RestaurantImageCarouselWidget(imgPaths),
                  //  Text(y.name),
                  RestaurantBadgeWidget(
                    rate: restaurant.rate.toPrecision(2),
                    restaurantName: restaurant.name,
                    type: restaurant.type,
                    reviewCount: restaurant.reviewCount,
                  ),
                  MenuSliderWidget_H(restaurant: restaurant,),
                  ReviewsSliderWidget_V(restaurant: restaurant,),
                ],
              ),
            );
          }
        });
  }
}
