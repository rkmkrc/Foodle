import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:foodle_app/HttpService/Auth/authServices.dart';
import 'package:foodle_app/HttpService/http_request.dart';
import 'package:foodle_app/constants.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({Key? key}) : super(key: key);

  @override
  RegisterFormWidgetState createState() {
    return RegisterFormWidgetState();
  }
}

class RegisterFormWidgetState extends State<RegisterFormWidget> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: "Username",
                labelText: "Username",
              ),
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: "Email",
                labelText: "Email",
              ),
              validator: (email) {
                if (!EmailValidator.validate(email!)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: "Password",
                labelText: "Password",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              validator: (password) {
                if (password!.isEmpty) {
                  return 'Password field can not be empty';
                }
                return null;
              },
            ),
          ),
        
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: color3,
                fixedSize: const Size(110, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {

                sendRegisterRequest(usernameController, emailController, passwordController);
              
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Sign Up'),
            ),
          ),
          
          
        ],
      ),
    );
  }
}
