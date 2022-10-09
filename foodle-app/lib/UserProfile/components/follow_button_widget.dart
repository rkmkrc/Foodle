import 'package:flutter/material.dart';

class FollowButtonWidget extends StatelessWidget {
  
  final String text;
  final VoidCallback onClicked;

  const FollowButtonWidget({ Key? key, required this.text, required this.onClicked }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        
        shape: const StadiumBorder(),
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 32 )
      ),
      child: Text(text),
      onPressed: onClicked,
    );
  }
}