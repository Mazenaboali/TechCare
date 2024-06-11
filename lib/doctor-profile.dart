import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tech_care/HomeScreen/doctor_home_screen.dart';
import 'package:tech_care/database/Doctor.dart';
import 'package:tech_care/database/My%20database.dart';

import 'Components/custom_button_auth.dart';

class DoctorProfileScreen extends StatefulWidget {
  static String routeName = "DoctorProfileScreen";
  var user=FirebaseAuth.instance.currentUser;

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.user?.email??"awawa");
  }
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<Doctor?>(
        future: MyDatabase.getDoctorData(widget.user!.email ?? ""),
        builder: (buildContext, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomAppBar(
                elevation: 0.1,
                color: Colors.white,
                height: 89,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'assets/images/home-icon.png',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, DoctorHomeScreen.routeName);
                          },
                        ),
                        Text(
                          'home',
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
                            'assets/images/chat-icon.png',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {},
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
                            'assets/images/filled-profile-icon.png',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, DoctorProfileScreen.routeName);
                          },
                        ),
                        Text(
                          'profile',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xff058383)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              body: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  )),
            );
          }

          var data = snapshot.data;
          if (snapshot.hasError) {
            return Scaffold(
              bottomNavigationBar: BottomAppBar(
                elevation: 0.1,
                color: Colors.white,
                height: 89,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'assets/images/home-icon.png',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, DoctorHomeScreen.routeName);
                          },
                        ),
                        Text(
                          'home',
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
                            'assets/images/chat-icon.png',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {},
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
                            'assets/images/filled-profile-icon.png',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, DoctorProfileScreen.routeName);
                          },
                        ),
                        Text(
                          'profile',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xff058383)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              body: Center(
                  child: Column(
                    children: [
                      Text(
                        'Error Loading data',
                        style: TextStyle(color: Colors.red),
                      ),
                      Container(
                        child: CustomButtonAuth(
                            title: 'Try again',
                            onPressed: () {
                              setState(() {});
                            }),
                      ),
                    ],
                  )),
            );
          }

          return Scaffold(
            bottomNavigationBar: BottomAppBar(
              elevation: 0.1,
              color: Colors.white,
              height: 95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Image.asset(
                          'assets/images/home-icon.png',
                          height: 24,
                          width: 24,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, DoctorHomeScreen.routeName);
                        },
                      ),
                      Text(
                        'home',
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
                          'assets/images/chat-icon.png',
                          height: 24,
                          width: 24,
                        ),
                        onPressed: () {},
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
                          'assets/images/filled-profile-icon.png',
                          height: 24,
                          width: 24,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, DoctorProfileScreen.routeName);
                        },
                      ),
                      Text(
                        'profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xff058383)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: data?.profileimagepath == null
                            ? ClipOval(
                          child: Image.asset(
                            "assets/images/profile.png",
                            height: 96,
                            width: 96,
                          ),
                        )
                            : ClipOval(
                                child: Image.file(
                                    fit: BoxFit.fill,
                                    height: 105,
                                    width: 105,
                                    File(
                                      data?.profileimagepath??"",
                                    ))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            data?.name??"_",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            data?.specialist??"_",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "About",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReadMoreText(
                      data?.about??"_",
                      style: TextStyle(color: Color(0xff221F1F), fontSize: 14),
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimCollapsedText: 'Reade more',
                      trimExpandedText: 'Read less',
                      moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff407CE2)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Career path",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReadMoreText(
                      data?.careerpath??"_",
                      style: TextStyle(color: Color(0xff221F1F), fontSize: 14),
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimCollapsedText: 'Reade more',
                      trimExpandedText: 'Read less',
                      moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff407CE2)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Available",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data?.available??"_",
                    style: TextStyle(
                      color: Color(0xff221F1F),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Phone Number",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data?.phonenumber??"_",
                    style: TextStyle(
                      color: Color(0xff221F1F),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                ],
              ),
            ),
          );
        });
  }
}
