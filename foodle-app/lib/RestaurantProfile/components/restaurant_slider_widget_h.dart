import 'package:flutter/material.dart';
import 'package:foodle_app/HttpService/Restaurant/restaurantServices.dart';
import 'package:foodle_app/Model/GetRestaurants.dart';
import 'package:foodle_app/Model/Restaurant.dart';
import 'package:foodle_app/RestaurantProfile/components/restaurant_card_widget.dart';

class RestaurantSliderWidget_H extends StatelessWidget {
  final int number;
  const RestaurantSliderWidget_H({
    Key? key, required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRestaurants(null,null,null,null,null,null,null,null),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            
            final json = snapshot.data ;
            final restaurantJson = json as List;
            var restaurantList =
                restaurantJson.map((data) => GetRestaurants.fromJson(data)).toList();
                print(restaurantList);
            
            return RestaurantSlider(restaurantList: restaurantList, number: number,);
          }
      },
      );
  }
}

class RestaurantSlider extends StatelessWidget {
  final List<GetRestaurants> restaurantList;
  final int number;
  const RestaurantSlider({
    Key? key,required this.restaurantList, required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(12,8,8,2),
              child: Text("Popular Restaurants", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
            ),
          ],
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: restaurantList.sublist(number,number+10)
                        .map((i) => RestaurantCardWidget(
                              restaurant: i,
                            ))
                        .toList(),
                        
                        
            ),
          ),
        ),
      ],
    );
  }
}
