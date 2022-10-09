import 'package:flutter/material.dart';
import 'package:foodle_app/Login/Components/LoginFormWidget.dart';
import 'package:foodle_app/Register/RegisterPage.dart';
import 'package:foodle_app/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; // Getting screen size of device being in use.

    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color3,
            color2,
          ],
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25,25,25,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,16,4),
              child: Text(
                "Sign In",
                style: GoogleFonts.karla(
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,16,16),
              child: GestureDetector(
                onTap: () => Get.to(const RegisterPage()),
                child: Text(
                  "Not have an account, create account!",
                  style: GoogleFonts.karla(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: LoginFormWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
