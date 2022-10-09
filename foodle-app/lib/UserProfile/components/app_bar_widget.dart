import 'package:flutter/material.dart';
import 'package:foodle_app/OTP/OtpPage.dart';

AppBar buildAppBar(BuildContext context){
  return AppBar(
    leading: BackButton(color: Colors.black,),
    backgroundColor: Color.fromRGBO(0, 0, 0, 0),
    elevation: 0,
    actions: [
      IconButton(onPressed: (){}, icon: Icon(Icons.settings, color: Colors.black,))
    ],
  );
}