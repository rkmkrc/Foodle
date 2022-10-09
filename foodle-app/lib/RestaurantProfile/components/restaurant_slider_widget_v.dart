import 'package:flutter/material.dart';
import 'package:foodle_app/RestaurantProfile/components/restaurant_card_widget.dart';
import 'package:get/get.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: RestaurantSliderWidget_V(),
    );
  }
}
class RestaurantSliderWidget_V extends StatelessWidget {
  const RestaurantSliderWidget_V({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(12,8,8,2),
                child: Text("Popular Restaurants", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
