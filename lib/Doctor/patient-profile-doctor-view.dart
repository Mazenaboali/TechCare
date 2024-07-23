import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tech_care/Chat/chat-screen.dart';
import 'package:tech_care/Chat/chats-screen.dart';
import 'package:tech_care/data/data%20base/My%20database.dart';
import 'package:tech_care/database/PatientDTO.dart';
import 'package:tech_care/Doctor/doctor-profile.dart';
import 'package:tech_care/presentation/Components/custom_button_auth.dart';
import 'package:tech_care/presentation/HomeScreen/doctor_home_screen.dart';

class PatientProfileDoctorView extends StatefulWidget {
  static String routeName = "PatientProfileDoctorView";
  String patienemail;
  String patientName = "";
  String? patientProfileImagePath;
  String identifyUser = "doctor";
  var user = FirebaseAuth.instance.currentUser;
  PatientProfileDoctorView({required this.patienemail});

  @override
  State<PatientProfileDoctorView> createState() =>
      _PatientProfileDoctorViewState();
}

class _PatientProfileDoctorViewState extends State<PatientProfileDoctorView> {
  @override
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('patient profile',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.1,
        color: Colors.white,
        height: 100,
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
                    Navigator.pushReplacementNamed(
                        context, DoctorHomeScreen.routeName);
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatsScreen('doctor')));
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
                    'assets/images/profile-icon.png',
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, DoctorProfileScreen.routeName);
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
      body: FutureBuilder<PatientDTO?>(
          future: MyDatabase.getPatientData(widget.patienemail),
          builder: (buildContext, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            }
            var data = snapshot.data;
            print(widget.patienemail);
            print('pp');
            if (snapshot.hasError) {
              return Center(
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
                ),
              );
            }
            print(data?.profileimagepath);
            widget.patientName = data?.name ?? "";
            return SingleChildScrollView(
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
                                child: Image.network(
                                data?.profileimagepath ?? "",
                                width: 96,
                                height: 96,
                                fit: BoxFit.fill,
                              )),
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
                            data?.name ?? "_",
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
                            data?.age ?? "_" + ' Years',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            data?.bloodtype ?? "_",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 150,
                    height: 32,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      receiverEmail: widget.patienemail,
                                      senderEmail: widget.user?.email ?? "",
                                      identifyUser: widget.identifyUser,
                                      receiverName: widget.patientName,
                                      receiverImagePath: data?.profileimagepath,
                                    )));
                      },
                      child: Text(
                        'Send Message',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      color: Color(0xff047676),
                      height: 32,
                      minWidth: 113,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Previous Surgeries",
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
                      data?.previoussurgeries ?? "_",
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
                    "Medication",
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
                      data?.medications ?? "_",
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
                    "Chronic Disease",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data?.chronicdisease ?? "_",
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
                    data?.phoneumber ?? "_",
                    style: TextStyle(
                      color: Color(0xff221F1F),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Height",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data?.height ?? "_",
                              style: TextStyle(
                                color: Color(0xff221F1F),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Weight",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data?.weight ?? "_",
                              style: TextStyle(
                                color: Color(0xff221F1F),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
