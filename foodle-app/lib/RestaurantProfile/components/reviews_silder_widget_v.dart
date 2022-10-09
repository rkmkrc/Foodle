import 'package:flutter/material.dart';
import 'package:foodle_app/HttpService/Review/reviewServices.dart';
import 'package:foodle_app/Model/Restaurant.dart';
import 'package:foodle_app/Model/Review.dart';
import 'package:foodle_app/Reviews/ReviewsPage.dart';
import 'package:foodle_app/UserProfile/components/review_card_widget.dart';
import 'package:get/get.dart';

class ReviewsSliderWidget_V extends StatelessWidget {
  final Restaurant restaurant;
  const ReviewsSliderWidget_V({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getRestaurantReviews(restaurant.restaurantID.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            
            final json = snapshot.data ;
            final reviewsJson = json as List;
            var reviewsList =
                reviewsJson.map((data) => Review.fromJson(data)).toList();
                print(reviewsList);
            
            return ReviewSlider(restaurant: restaurant, reviewsList: reviewsList);
          }
        });
  }
}

class ReviewSlider extends StatelessWidget {
  const ReviewSlider({
    Key? key,
    required this.restaurant,
    required this.reviewsList,
  }) : super(key: key);

  final Restaurant restaurant;
  final List<Review>reviewsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: const Text(
                  "Top Reviews",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onTap: () {
                  Get.to(ReviewsPage(
                    restaurant: restaurant, reviewsList: reviewsList,
                  ));
                },
              ),
              GestureDetector(
                child: const Text(
                  "(see all)",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      color: Colors.black),
                ),
                onTap: () {
                  Get.to(ReviewsPage(
                    restaurant: restaurant,
                    reviewsList: reviewsList,
                  ));
                },
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.753,
          width: MediaQuery.of(context).size.width * 0.95,
          child: SizedBox(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: reviewsList
                        .map((i) => ReviewCardWidget(
                              review: i,
                            ))
                        .toList()
                    /*children: [
                 ReviewCardWidget(),
                ReviewCardWidget(),
                ReviewCardWidget(),
                ReviewCardWidget(),
                ReviewCardWidget(), 
              ],*/
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
