import 'dart:convert';
import 'dart:io' as io;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:foodle_app/Home/UserHomePage.dart';
import 'package:foodle_app/HttpService/UserInfo/fileOperations.dart';
import 'package:foodle_app/Login/LoginPage.dart';
import 'package:foodle_app/OTP/OtpPage.dart';
import 'package:foodle_app/Onboarding/OnboardingPage.dart';
import 'package:foodle_app/RestaurantProfile/RestaurantProfilePage.dart';
import 'package:foodle_app/UserProfile/EditUserProfilePage.dart';
import 'package:foodle_app/UserProfile/UserProfilePage.dart';
import 'package:foodle_app/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/_io/_file_decoder_io.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> sendLoginRequest(TextEditingController usernameController,
    TextEditingController passwordController) async {
  String hashedPassword = hashPassword(passwordController.text);
  print("----" + hashedPassword);
  var sharedPreferences = await SharedPreferences.getInstance();

  var url = Uri.parse('http://172.16.3.237:3000/auth/login');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: JsonEncoder().convert({
        "userCredentials": {
          "userName": usernameController.text,
          "hashedPassword": hashedPassword,
        }
      }));
  if (response.statusCode == 200) {
    print("-------------GİRDİİİ--------------");
    print('AccessToken LOGIN ==>>, ${sharedPreferences.getString("accessToken")}');
    print('UserID LOGIN ==>> ${sharedPreferences.getInt("userID")}.');

    
    Get.to(() => OtpPage(
        hashedPassword: hashedPassword,
        username: usernameController.text,
        fromLogin: true));
  } else {
    print("-------------------GİRMEDİ--------------");
  }

  print(response.body);
}

Future<void> sendLogoutRequest() async {
  var sharedPreferences = await SharedPreferences.getInstance();

  var url = Uri.parse('http://172.16.3.237:3000/user/logout');
  var response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": sharedPreferences.getString("accessToken").toString(),
        "CurrentUserID": sharedPreferences.getInt("userID").toString(),
      },
      body: JsonEncoder().convert({}));
  if (response.statusCode == 200) {
    print("-------------LOGOUT Successfull--------------");
    Get.to(() => LoginPage());
  } else {
    print("-------------------Logout UNsuccessfull--------------");
  }

  print(response.body);
}

Future<void> sendRegisterRequest(
    TextEditingController usernameController,
    TextEditingController emailController,
    TextEditingController passwordController) async {
  String username = usernameController.text;
  String hashedPassword = hashPassword(passwordController.text);
  String email = emailController.text;

  var url = Uri.parse('http://172.16.3.237:3000/auth/register');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: JsonEncoder().convert({
        "userCredentials": {
          "userName": username,
          "hashedPassword": hashedPassword,
          "email": email,
          "phoneNumber": ""
        },
        "userInfo": {
          "name": "",
          "surname": "",
          "birthDate": "",
          "gender": "",
          "profilePicture": ""
        }
      }));

  if (response.statusCode == 200) {
    print("-------------GİRDİİİ--------------");
    writeCounter(1233);

    Get.to(() => OtpPage(
          username: username,
          hashedPassword: hashedPassword,
          fromLogin: false,
        ));
  } else {
    print("-------------------GİRMEDİ--------------");
    print(response.statusCode);
  }
}

Future<void> sendOtpRequest(
    String username, String hashedPassword, String pin, bool fromLogin) async {
  var sharedPreferences = await SharedPreferences.getInstance();

  print(
      "OTP START -------------------\n Shared Pref: ${sharedPreferences.getString("accessToken")} \n Shared Pref: ${sharedPreferences.getInt("userID")}");
  var url = Uri.parse('http://172.16.3.237:3000/auth/login?action=confirmOTP');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: JsonEncoder().convert({
        "userCredentials": {
          "userName": username,
          "hashedPassword": hashedPassword,
          "OTP": pin,
        }
      }));
  if (response.statusCode == 200) {
    print("-------------OTP TRUE--------------");
    print(response.body);

    Map<String, dynamic> user = jsonDecode(response.body);

    print('AccessToken OTP ==>>, ${user['accesstoken']}');
    print('UserID OTP ==>> ${user['userid']}.');

    sharedPreferences.setString("accessToken", user['accesstoken']);
    sharedPreferences.setInt("userID", user['userid']);
    if (fromLogin)
      Get.to(() => UserHomePage());
    else {
      Get.to(() => EditUserProfilePage());
    }
  } else {
    print("username = $username - hpwd = $hashedPassword - pin = $pin");
    print("-------------------OTP YANLIS--------------");
  }
}

Future<void> checkAuth() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accesstoken").toString();
  String userName = ""; // Implement later
  var url = Uri.parse('http://172.16.3.237:3000/user/uploadphoto');
  var response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": accessToken,
        "CurrentUserID": userID,
      },
      body: JsonEncoder().convert({
        "userCredentials": {"userName": userName} // Implement later
      }));
  if (response.statusCode == 200) {
    print("-------------uploadUserPhoto SUCCESS--------------");
  } else {
    print("-------------uploadUserPhoto UNSUCCESS--------------");
  }

  print(response.body);
}

String hashPassword(String enteredPassword) {
  var bytes = utf8.encode(enteredPassword); // data being hashed
  var digest = sha1.convert(bytes);
  String hashedPassword = base64.encode(digest.bytes);
  return hashedPassword;
}

void setAccessTokenAndUserID(Response response) {}

Future<void> readySharedPreferences() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.getString("accessToken") ?? "";
  sharedPreferences.getInt("userID") ?? 0;
  setState() {}
}
