import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foozave/models/foodModel.dart';
import 'package:foozave/utils/AppTheme.dart';
import 'package:foozave/utils/locationservices.dart';
import 'package:foozave/utils/apireq.dart';

class AddFoodScreen extends StatefulWidget {
  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  late TextTheme textTheme;
  String dateTimeSelected = DateTime.now().toString();
  List<double> coordinates = [0.0, 0.0];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Dialog(
      clipBehavior: Clip.hardEdge,
      insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Text(
                        'Give away food!',
                        style: AppTheme.getTextStyle(textTheme.headline4!,
                            color: Colors.greenAccent[700]),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: nameController,
                        style: AppTheme.getTextStyle(textTheme.bodyText1!,
                            letterSpacing: 0.1, fontWeight: 500),
                        decoration: InputDecoration(
                          hintStyle: AppTheme.getTextStyle(textTheme.subtitle2!,
                              letterSpacing: 0.1, fontWeight: 500),
                          hintText: "Give your name here.",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Row(
                        children: [
                          Text('Location details:'),
                          SizedBox(
                            width: 7,
                          ),
                          TextButton.icon(
                              onPressed: () async {
                                requestPermission();
                                var loc = await getCurrentLocation();
                                setState(() {
                                  coordinates = [
                                    loc.latitude ?? 0.0,
                                    loc.longitude ?? 0.0
                                  ];
                                });
                              },
                              label: Text(
                                'My Location',
                                style: TextStyle(color: Color(0xffF6511F)),
                              ),
                              icon: Icon(Icons.my_location,
                                  color: Color(0xffF6511F)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: descriptionController,
                        maxLines: 10,
                        style: AppTheme.getTextStyle(textTheme.bodyText1!,
                            letterSpacing: 0.1, fontWeight: 500),
                        decoration: InputDecoration(
                          hintStyle: AppTheme.getTextStyle(textTheme.subtitle2!,
                              letterSpacing: 0.1, fontWeight: 500),
                          hintText:
                              "Details about the food available and contact info goes here.",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Column(
                        children: [
                          Text(
                            'Choose a time till when the food will be available:',
                            overflow: TextOverflow.clip,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          DateTimePicker(
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'd MMM, yyyy',
                            //controller: dateTimeController,
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(Icons.event),
                            dateLabelText: 'Date',
                            timeLabelText: "Hour",
                            onChanged: (val) =>
                                setState(() => dateTimeSelected = val),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          if (nameController.text.isEmpty ||
                              descriptionController.text.isEmpty ||
                              listEquals(coordinates, [0.0, 0.0]) ||
                              DateTime.parse(dateTimeSelected)
                                  .isBefore(DateTime.now()) ||
                              DateTime.parse(dateTimeSelected)
                                  .isAtSameMomentAs(DateTime.now())) {
                            Fluttertoast.showToast(
                                msg: "Check all the fields!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black87,
                                textColor: Colors.white,
                                fontSize: 14.0);
                            return;
                          }
                          Location loc = Location(coordinates: coordinates);
                          Food food = Food(
                              name: nameController.text,
                              description: descriptionController.text,
                              location: loc,
                              expireAt: DateTime.parse(dateTimeSelected),
                              date: DateTime.now());
                          postReq(food).then((value) => Navigator.pop(context));
                        },
                        child: Container(
                          height: 55.0,
                          width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                              colors: [Color(0xFF2193B0), Color(0xFF6DD5ED)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Post Details",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Sofia",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19.0,
                                  letterSpacing: 1.1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
