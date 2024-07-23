import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/Chat/chats-screen.dart';
import 'package:tech_care/Doctor/Review-examination.dart';
import 'package:tech_care/data/data%20base/My%20database.dart';
import 'package:tech_care/database/examinationDTO.dart';
import 'package:tech_care/Doctor/doctor-profile.dart';
import 'package:tech_care/presentation/Components/custom_button_auth.dart';
import 'package:tech_care/presentation/Components/examination_widget.dart';
import 'package:tech_care/presentation/HomeScreen/doctor_home_screen.dart';

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ChatsScreen('doctor')
                        )
                    );
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
                    Navigator.pushReplacementNamed(context, DoctorProfileScreen.routeName);
                  },
                ),
                Text(
                  'profile',
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
      body: FutureBuilder<List<ExaminationDTO>>(
          future: MyDatabase.getExaminations('doctor',user?.email??""),
          builder: (buildContext, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
            }

            var data = snapshot.data;
            print(data?.length);
            print("wlam");
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
             List<String>m=["ll"];
            List<dynamic>l=m;
            if (data?.length == 0) {
              return Center(
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                      ),
                      Image.asset('assets/images/add-record.png',width: 300,height: 300,),
                      Container(
                        height: 30,
                      ),
                      Text(
                        'You have not added any medical records yet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 30,
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
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ReviewExamination(
                        doctorImagePath: data?[index].doctorimagepath,
                          userEmail:data?[index].patientemail??"",
                          identifyuser: 'patient',
                          id: data?[index].id??"",
                          doctorname: data?[index].doctorname??"_",
                          doctoradress: data?[index].doctoradress??"_",
                          date: data?[index].date??"_",
                          patientname: data?[index].patientname??"",
                          report: data?[index].report??"",
                          prescriptiontext: data?[index].prescriptiontext,
                          prescriptionimagepath: data?[index].prescriptionimagepath,
                          analysisimagepath: data?[index].analysisimagepath)),
                    );
                  },
                  child: ExaminationWidget(
                    reviewOrAddAnalysis: false,
                    ispatient: true,
                    PatientorDoctorEmail: data?[index].patientemail??"",
                    name: data?[index].patientname??"",
                    date: data?[index].date??"",
                    profileimagepath: data?[index].patientimagepath??"",
                  ),
                );
              },
              itemCount: data?.length,
            );
          }),
    );
  }
}
