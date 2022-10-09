import 'dart:convert';
import 'dart:io' as io;
import 'package:foodle_app/Home/UserHomePage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



Future<void> sendUserUpdateRequest(
  String name,
  String surname,
  String gender,
  String birthDate,
) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  var url = Uri.parse('http://172.16.3.237:3000/user/update');
  var response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": sharedPreferences.getString("accessToken").toString(),
        "CurrentUserID": sharedPreferences.getInt("userID").toString(),
      },
      body: JsonEncoder().convert({
        "name": name,
        "surname": surname,
        "birthDate": birthDate,
        "gender": gender,
        "data": "",
      }));
  if (response.statusCode == 200) {
    print("-------------Updated--------------");
    Get.to(() => UserHomePage());
  } else {
    print("-------------------Can NOT Update--------------");
  }

  print(response.body);
}

Future<void> getDetailedUserData() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accesstoken").toString();

  var url = Uri.parse('http://172.16.3.237:3000/user?userID=$userID');
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------getDetailedUserData SUCCESS--------------");
  } else {
    print("-------------getDetailedUserData UNSUCCESS--------------");
  }

  print(response.body);
}

Future<void> getUsersWithKeyword(String searchedKeyword) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accesstoken").toString();

  var url = Uri.parse(
      'http://172.16.3.237:3000/user/getUsers?keyword=$searchedKeyword');
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------getUserWithKeyword SUCCESS--------------");
  } else {
    print("-------------getUserWithKeyword UNSUCCESS--------------");
  }

  print(response.body);
}

Future<void> sendUserFollowRequest(String userIDtoBeFollowed) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accesstoken").toString();

  var url = Uri.parse(
      'http://172.16.3.237:3000/user/follow?userID=$userIDtoBeFollowed');
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": accessToken,
      "CurrentUserID": userID,
    },
  );
  if (response.statusCode == 200) {
    print("-------------sendUserFollowRequest SUCCESS--------------");
  } else {
    print("-------------sendUserFollowRequest UNSUCCESS--------------");
  }

  print(response.body);
}

Future<void> uploadUserPhoto(image) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String userID = sharedPreferences.getInt("userID").toString();
  String accessToken = sharedPreferences.getString("accesstoken").toString();
  String photo = encodePhotoToBase64(image) as String;

  var url = Uri.parse('http://172.16.3.237:3000/user/uploadphoto');
  var response = await http.post(url, headers: {
    'Content-Type': 'application/json',
    "Authorization": accessToken,
    "CurrentUserID": userID,
  }, body: JsonEncoder().convert({
    "data": photo,
  }));
  if (response.statusCode == 200) {
    print("-------------uploadUserPhoto SUCCESS--------------");
  } else {
    print("-------------uploadUserPhoto UNSUCCESS--------------");
  }

  print(response.body);
}



Future<String> encodePhotoToBase64(image) async {
  final bytes = await io.File(image).readAsBytes();
  String base64Encode(List<int> bytes) => base64.encode(bytes);
  return base64Encode(bytes);
}


