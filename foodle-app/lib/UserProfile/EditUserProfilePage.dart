import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodle_app/HttpService/http_request.dart';
import 'package:foodle_app/UserProfile/components/gender_picker_widget.dart';
import 'package:foodle_app/UserProfile/components/gender_provider.dart';
import 'package:foodle_app/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditUserProfilePage(),
    );
  }
}

class EditUserProfilePage extends StatefulWidget {
  const EditUserProfilePage({Key? key}) : super(key: key);

  @override
  _EditUserProfilePageState createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  File? image;
  String initValue = "Select your Birth Date";
  bool isDateSelected = false;
  late DateTime birthDate; // instance of DateTime
  late String birthDateInString = "01-01-2000";
  var gp = GenderPickerWidget();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      File imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            "Edit Your Profile",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 25,
          ),
          UserPPEditWidget(),
          OneLineInputWidget(nameController, "Name"),
          OneLineInputWidget(surnameController, "Surname"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Select your birthdate",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          child: Icon(
                            Icons.calendar_today,
                            size: 35,
                            color: Colors.blue.shade600,
                          ),
                          onTap: () async {
                            final datePick = await showDatePicker(
                                context: context,
                                initialDate: new DateTime.now(),
                                firstDate: new DateTime(1900),
                                lastDate: new DateTime(2100));

                            setState(() {
                              birthDate = datePick!;
                              isDateSelected = true;

                              birthDateInString =
                                  "${birthDate.day}-${birthDate.month}-${birthDate.year}"; // 08/14/2019
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Gender",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(width: 250, height: 100, child: gp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text("Submit"),
              onPressed: () {
                print(nameController.text);
                print(surnameController.text);
                print(birthDateInString);
                print(" --- " + gp.isMalex.toString() + " --- ");
                // photo will be added
                sendUserUpdateRequest(
                    nameController.text,
                    surnameController.text,
                    gp.isMalex ? "M" : "F",
                    birthDateInString);

              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade800,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      )),
    );
  }

  Padding UserPPEditWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipOval(
                        child: Image.file(
                          image!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            image = null;
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.close_outlined,
                            )),
                      ),
                    ],
                  )
                : Stack(alignment: Alignment.topRight, children: [
                    GestureDetector(
                      onTap: () => pickImage(),
                      child: ClipOval(
                          child: Image.asset("assets/images/default_userpp.png",
                              height: 120, width: 120, fit: BoxFit.cover)),
                    ),
                    GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: const Icon(
                            Icons.edit,
                            size: 25,
                          )),
                    ),
                  ]),
          ],
        ),
      ),
    );
  }

  OneLineInputWidget(inputController, String hintText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  hintText,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintText: hintText,
                    ),
                    maxLines: 1,
                    minLines: 1,
                    controller: inputController,
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
