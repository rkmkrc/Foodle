import 'package:flutter/material.dart';
import 'package:foodle_app/Home/UserHomePage.dart';
import 'package:foodle_app/Login/LoginPage.dart';
import 'package:foodle_app/Onboarding/OnboardingPage.dart';
import 'package:foodle_app/Register/RegisterPage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1)); // To show splash screen for 1 second
  
  SharedPreferences prefs = await SharedPreferences.getInstance(); // To indicate whether the very first time launch or not
  initScreen = (await prefs.getInt("initScreen")); // In order to show onboarding page just first launch.    
  await prefs.setInt("initScreen", 1);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initScreen == 0 || initScreen == null ? "firstLaunch" : "notFirstLaunch",
      routes: {
        'notFirstLaunch': (context) => RegisterPage(),
        "firstLaunch": (context) => OnBoardingPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return OnBoardingPage();
}
}