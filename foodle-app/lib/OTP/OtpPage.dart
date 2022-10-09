import 'package:flutter/material.dart';
import 'package:foodle_app/HttpService/Auth/authServices.dart';
import 'package:foodle_app/HttpService/http_request.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/* void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KindaCode.com',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: OtpPage(username: "", hashedPassword: "",),
    );
  }
} */

class OtpPage extends StatefulWidget {
  final String username;
  final String hashedPassword;
  final bool fromLogin;
  
  const OtpPage({Key? key, required this.username, required this.hashedPassword, required this.fromLogin}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState(username, hashedPassword);
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  final String username;
  final String hashedPassword;

  _OtpPageState(this.username, this.hashedPassword);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: PinCodeTextField(
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.blue.shade50,
            enableActiveFill: true,
            controller: textEditingController,
            onCompleted: (v) {
              debugPrint("Completed === ${textEditingController.text} \n Username = $username - HPwd = $hashedPassword");
              sendOtpRequest(username, hashedPassword, textEditingController.text,widget.fromLogin);
              
            },
            onChanged: (value) {
              debugPrint(value);
              setState(() {
                currentText = value;
              });
            },
            beforeTextPaste: (text) {
              return true;
            },
            appContext: context,
          ),
        ),
      ),
    );
  }

}