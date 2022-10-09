import 'package:flutter/material.dart';
import 'package:foodle_app/Model/Restaurant.dart';
import 'package:foodle_app/Model/Review.dart';
import 'package:foodle_app/RestaurantProfile/components/restaurant_badge_widget.dart';
import 'package:foodle_app/RestaurantProfile/components/reviews_silder_widget_v.dart';
import 'package:foodle_app/UserProfile/components/review_card_widget.dart';

class ReviewsPage extends StatefulWidget {
  final Restaurant restaurant;
  final List<Review> reviewsList;
  const ReviewsPage({Key? key, required this.restaurant,required this.reviewsList}) : super(key: key);

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
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
            type: widget.restaurant.type,
            rate: widget.restaurant.rate,
            reviewCount: widget.restaurant.reviewCount,
            restaurantName: widget.restaurant.name,
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
                  "Top Reviews",
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
                      children: [
                        ReviewsSliderWidget_V(restaurant: widget.restaurant)
                      ],
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
