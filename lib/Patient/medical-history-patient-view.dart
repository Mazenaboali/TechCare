import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/Chat/chats-screen.dart';
import 'package:tech_care/Components/custom_button_auth.dart';
import 'package:tech_care/Components/examination_widget.dart';
import 'package:tech_care/HomeScreen/patient_home_screen.dart';
import 'package:tech_care/Patient/Patient_Profile.dart';
import 'package:tech_care/Patient/Review-examination-or-add%20analysis.dart';
import 'package:tech_care/Provider/get-data-provider.dart';
import 'package:tech_care/database/My%20database.dart';
import 'package:tech_care/database/examination.dart';

class MedicalHistoryPatientViewScreen extends StatefulWidget {
  static String routeName = "MedicalHistoryPatientViewScreen";
  String doctoremail = "";
  @override
  State<MedicalHistoryPatientViewScreen> createState() =>
      _MedicalHistoryPatientViewScreenState();
}

class _MedicalHistoryPatientViewScreenState
    extends State<MedicalHistoryPatientViewScreen> {
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
          'Medical History',
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
                        context, PatientHomeScreen.routeName);
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
                            builder: (context) => ChatsScreen('patient')));
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
                        context, PatientProfile.routeName);
                  },
                ),
                Text(
                  'Profile',
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
          future: MyDatabase.getExaminations('patient',user?.email ?? ""),
          builder: (buildContext, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            }

            var data = snapshot.data;
            if (snapshot.hasError) {
              print(snapshot);
              return Center(
                  child: Column(
                children: [
                  Container(height: 50,),
                  Image.asset('assets/images/error-image.png'),
                  Text(
                    'Error Loading data',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(height: 20,),
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
            if (data?.length==0) {
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
                              Navigator.pushReplacementNamed(context,PatientHomeScreen.routeName);
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
                      MaterialPageRoute(builder: (context) =>  ReviewExaminationOrAddAnalysis(
                           doctorImagePath:data[index].doctorimagepath,
                          userEmail:data[index].patientemail,
                          identifyuser: 'patient',
                          id: data[index].id??"",
                          doctorname: data[index].doctorname,
                          doctoradress: data[index].doctoradress,
                          date: data[index].date,
                          patientname: data[index].patientname,
                          report: data[index].report,
                          prescriptiontext: data[index].prescriptiontext,
                          prescriptionimagepath: data[index].prescriptionimagepath,
                          analysisimagepath: data[index].analysisimagepath)),
                    );
                  },
                  child: ExaminationWidget(

                    reviewOrAddAnalysis: true,
                    ispatient: false,
                    PatientorDoctorEmail: data?[index].doctoremail??"",
                    name: data![index].doctorname??"",
                    date: data[index].date??"",
                    profileimagepath: data[index].doctorimagepath,
                  ),
                );
              },
              itemCount: data?.length??0,
            );
          }),
    );
  }
}
