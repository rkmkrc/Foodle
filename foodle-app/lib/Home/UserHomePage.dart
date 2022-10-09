import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodle_app/RestaurantProfile/RestaurantProfilePage.dart';
import 'package:foodle_app/RestaurantProfile/components/restaurant_slider_widget_h.dart';
import 'package:foodle_app/RestaurantProfile/components/reviews_silder_widget_v.dart';
import 'package:foodle_app/Settings/SettingsPage.dart';
import 'package:foodle_app/UserProfile/UserProfilePage.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserHomePage(),
    );
  }
}

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    var imgPaths = [
      "assets/images/rest3.png",
      "assets/images/rest2.png",
      "assets/images/rest1.png"
    ];

    TextEditingController searchCont = TextEditingController();
    return Scaffold(
       bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,), 
      //appBar: buildAppBar(context),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 219, 244, 247),
                        Color.fromARGB(255, 165, 167, 166),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Row(
                          children: [
                            buildImage(
                              "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770",
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Hello Erkam, find your next restaurant!",
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),

              /* Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ), */
              /* AnimSearchBar(
                        rtl: true,
                        autoFocus: true,
                        helpText: "Search",
                        closeSearchOnSuffixTap: true,
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        textController: searchCont,
                        onSuffixTap: () {}), */
              RestaurantSliderWidget_H(number:0),
              RestaurantSliderWidget_H(number:10),
              RestaurantSliderWidget_H(number:20),
         //     SizedBox(child: ReviewsSliderWidget_V(restaurant: ,)),
              // RestaurantSliderWidget_V(),
            ],
          ),
         // RestaurantProfilePage(),
          UserProfilePage(),
          SettingsPage(),
        ],
      ),
    );
  }

  Widget buildImage(imagePath) {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          height: 60,
          width: 60,
          child: InkWell(onTap: () {}),
        ),
      ),
    );
  }
}
