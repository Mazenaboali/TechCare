import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/Components/custom_button_auth.dart';
import 'package:tech_care/Components/examination_widget.dart';
import 'package:tech_care/HomeScreen/doctor_home_screen.dart';
import 'package:tech_care/database/My%20database.dart';
import 'package:tech_care/database/examination.dart';
import 'package:tech_care/doctor-profile.dart';

class ExaminationDoctorViewScreen extends StatefulWidget {
  static String routeName = "ExaminationDoctorViewScreen";

  @override
  State<ExaminationDoctorViewScreen> createState() =>
      _ExaminationDoctorViewScreenState();
}

class _ExaminationDoctorViewScreenState
    extends State<ExaminationDoctorViewScreen> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Examinations',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xff191D31),
              fontSize: 16),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.1,
        color: Colors.white,
        height:100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/filled-home-icon.png',
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, DoctorHomeScreen.routeName);
                  },
                ),
                Text(
                  'home',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff058383)),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/chat-icon.png',
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {

                  },
                ),
                Text(
                  'Chat',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff7A7979)),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/notification-icon.png',
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {},
                ),
                Text(
                  'Notification',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff7A7979)),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/profile-icon.png',
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, DoctorProfileScreen.routeName);
                  },
                ),
                Text(
                  'Chat',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff7A7979)),
                )
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Examination>>(
          future: MyDatabase.getExaminations("sameh@gmail.com"),
          builder: (buildContext, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
            }

            var data = snapshot.data;
            print(data);
            if (snapshot.hasError) {
              return Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/error-image.png'),
                      Text(
                        'Error Loading data',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        child: CustomButtonAuth(
                            title: 'Try again',
                            onPressed: () {
                              setState(() {});
                            }),
                      ),
                    ],
                  ));
            }
            if (data == null) {
              return Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/add-record.png'),
                      Container(
                        height: 20,
                      ),
                      Text(
                        'You have not added any medical records yet',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        child: MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context,DoctorHomeScreen.routeName);
                            },
                            child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF023535),
                                    Color(0xFF069B9B),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Add records',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ));
            }
            return ListView.builder(
              itemBuilder: (_, index) {
                return ExaminationWidget(
                  name: data[index].patientname,
                  date: data[index].date,
                  profileimagepath: data[index].patientimagepath,
                );
              },
              itemCount: data.length,
            );
          }),
    );
  }
}
