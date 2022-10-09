import 'package:flutter/material.dart';
import 'package:foodle_app/constants.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget(
      {Key? key, required this.imagePath, required this.onClicked, this.isEdit = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        buildImage(),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon(Colors.red.shade400),
        ),
      ]),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          height: 128,
          width: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
        color: color,
        all: 8,
        child: Icon(
          isEdit? Icons.add_a_photo: Icons.edit,
          size: 20,
          color: Colors.white,
        ),
      ),
  );
  

  Widget buildCircle({required Color color, required double all, required Widget child}) => 
  ClipOval(
    child: Container(
      color: color,
      child: child,
      padding: EdgeInsets.all(all),
    ),
  );
}
