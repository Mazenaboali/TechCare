import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tech_care/Doctor/patient-profile-doctor-view.dart';
import 'package:tech_care/Patient/doctor-profile-patient-view.dart';
import 'package:tech_care/database/examination.dart';

class ExaminationWidget extends StatelessWidget{
  String date;
  String? profileimagepath;
  String name;
  bool ispatient;
  bool reviewOrAddAnalysis;
  String PatientorDoctorEmail;

  ExaminationWidget({

    required this.date,this.profileimagepath,
    required this.name,
    required this.ispatient,
    required this.reviewOrAddAnalysis,
    required this.PatientorDoctorEmail,

  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
          child: Container(
            height: 100,
            width: 360,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft:Radius.circular(8) ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, -3), // changes the shadow direction vertically
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  if(ispatient==true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          PatientProfileDoctorView(patienemail:
                              PatientorDoctorEmail)),
                    );
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          DoctorProfilePatientViewScreen(doctoremail:
                          PatientorDoctorEmail)),
                    );
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    profileimagepath == null||profileimagepath==""
                        ? ClipOval(
                      child: Image.asset(
                        "assets/images/profile.png",
                        height: 50,
                        width: 50,
                      ),
                    )
                        : ClipOval(
                        child: Image.file(
                            fit: BoxFit.fill,
                            height: 45,
                            width: 45,
                            File(
                              profileimagepath??"",
                            ))),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                       ispatient? Text(
                          "${name}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff263257)),
                        ):Text(
                         " Dr / ${name}",
                         style: TextStyle(
                             fontWeight: FontWeight.w500,
                             fontSize: 16,
                             color: Color(0xff263257)),
                       ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          date,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xff8A96BC)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

        ),
        Container(
          width: 360,
          height: 42.33,
          padding: EdgeInsets.all(9.00553),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
            ),
            gradient: LinearGradient(
              begin: Alignment(-1.09, -1.14),
              end: Alignment(0.88, 1.15),
              colors: [
                Color(0xFF023535),
                Color(0xFF069B9B)
              ],
              stops: [0.0, 1.0],
            ),
          ),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              reviewOrAddAnalysis==false?  Text(
                "Review",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ): Text(
              "Review or add analysis",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
              SizedBox(
                width: 10,
              ),
              Image.asset('assets/images/medical-history-icon.png')
            ],
          ),
        )
      ],
    );
  }
}