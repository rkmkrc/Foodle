import 'package:flutter/material.dart';

class UserNumbersWidget extends StatelessWidget {
  const UserNumbersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildNumbersButton(context, "15k", "Followers"),
          Container(
            height: 24,
            child: const VerticalDivider(
              color: Colors.black,
            ),
          ),
          buildNumbersButton(context, "3020", "Following"),
          Container(
            height: 24,
            child: const VerticalDivider(
              color: Colors.black,
            ),
          ),
          buildNumbersButton(context, "45", "Reviews"),
        ],
      ),
    );
  }

  Widget buildNumbersButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
