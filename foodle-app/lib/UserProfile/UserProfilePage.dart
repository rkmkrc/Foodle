import 'package:flutter/material.dart';
import 'package:foodle_app/Model/User.dart';
import 'package:foodle_app/UserProfile/EditUserProfilePage.dart';
import 'package:foodle_app/UserProfile/components/app_bar_widget.dart';
import 'package:foodle_app/UserProfile/components/follow_button_widget.dart';
import 'package:foodle_app/UserProfile/components/profile_widget.dart';
import 'package:foodle_app/UserProfile/components/review_card_widget.dart';
import 'package:foodle_app/UserProfile/components/user_numbers_widget.dart';
import 'package:foodle_app/Utils/user_preferences.dart';
import 'package:foodle_app/constants.dart';
import 'package:get/get.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(imagePath: user.imagePath, onClicked: () async {
            Get.to(() => EditUserProfilePage());
          }),
          const SizedBox(
            height: 24,
          ),
          BuildUserName(user),
          const SizedBox(
            height: 24,
          ),
          Center(child: BuildFollowButton(user)),
          const SizedBox(
            height: 24,
          ),
          const UserNumbersWidget(),
          const SizedBox(
            height: 18,
          ),
          BuildUserAbout(user),
          const SizedBox(
            height: 18,
          ),
          /* const Text("Reviews",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center), */
          const SizedBox(
            height: 2,
          ),
          const SizedBox(
            height: 2,
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
            /*   BuildUserReviewsCard(user),
              BuildUserReviewsCard(user),
              BuildUserReviewsCard(user),
              BuildUserReviewsCard(user) */
            ]),
          ),
        ],
      ),
    );
  }

  Widget BuildUserAbout(User user) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          constraints: BoxConstraints(maxWidth: 350),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "About",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 38, vertical: 18),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                          bottom: Radius.circular(30))),
                  child: Text(
                    "  ${user.about}",
                    style: const TextStyle(fontSize: 16, height: 1.4),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      );

  Widget BuildUserName(User user) {
    return Column(
      children: [
        Text(
          user.userName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          user.email,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  Widget BuildFollowButton(User user) =>
      FollowButtonWidget(text: "Follow", onClicked: () {});

//  Widget BuildUserReviewsCard(User user) => ReviewCardWidget();
}
