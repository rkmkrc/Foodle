import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodle_app/Model/Meal.dart';
import 'package:foodle_app/Model/Review.dart';
import 'package:foodle_app/Utils/user_preferences.dart';
import 'profile_widget.dart';

class ReviewCardWidget extends StatelessWidget {
  final Review review;
  const ReviewCardWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
      child: Container(
        constraints: BoxConstraints(minWidth: 355, maxWidth: 355),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
              border: Border.all(color: Colors.grey.shade500, width: 1),
            ),
        child: Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildUserInfoForCard(user),
                  RatingBar.builder(
                    itemSize: 20,
                    initialRating: 3,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(
                    review.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(
                    review.price.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 500,
              child: Container(
                
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(0), bottom: Radius.circular(30))),
                  child: Text(
                    review.text,
                    style: const TextStyle(fontSize: 14, height: 1.2),
                    textAlign: TextAlign.start,
                  ),),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(user) {
    final image = NetworkImage(user.imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          height: 128,
          width: 128,
          child: InkWell(onTap: () {}),
        ),
      ),
    );
  }

  Widget buildUserInfoForCard(user) {
    return Row(
      children: [
        Container(height: 50, width: 50, child: buildImage(user)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                user.userName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 1,
              ),
              const Text("20.08.2021"),
            ],
          ),
        ),
      ],
    );
  }
}
