import 'package:flutter/material.dart';
import 'package:foodle_app/UserProfile/components/gender_provider.dart';
import 'package:provider/provider.dart';

class GenderPickerWidget extends StatefulWidget {
  bool isMalex = true;
  GenderPickerWidget({Key? key}) : super(key: key);

  @override
  _GenderPickerWidgetState createState() => _GenderPickerWidgetState();
}

class _GenderPickerWidgetState extends State<GenderPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GenderProvider>(
      create: (context) => GenderProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      // MALE
                      Expanded(
                        child: Consumer<GenderProvider>(
                          builder: (context, genderProvider, _) =>
                              GestureDetector(
                            onTap: () {
                              widget.isMalex = true;
                              genderProvider.isMale = true;
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: genderProvider.maleColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Male',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: genderProvider.maleColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      // FEMALE
                      Expanded(
                        child: Consumer<GenderProvider>(
                          builder: (context, genderProvider, _) =>
                              GestureDetector(
                            onTap: () {
                              widget.isMalex=false;
                              genderProvider.isMale = false;
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: genderProvider.femaleColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Female',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: genderProvider.femaleColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
