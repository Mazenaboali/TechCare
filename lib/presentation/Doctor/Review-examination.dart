import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui';


class ReviewExamination extends StatefulWidget {
  String? doctorImagePath;
  String identifyuser;
  String userEmail;
  String doctorname;
  String id;
  String doctoradress;
  String date;
  String patientname;
  String report;
  String? prescriptiontext;
  String? prescriptionimagepath;
  List<dynamic>? analysisimagepath;

  ReviewExamination({
    required this.doctorImagePath,
    required this.userEmail,
    required this.identifyuser,
    required this.id,
    required this.doctorname,
    required this.doctoradress,
    required this.date,
    required this.patientname,
    required this.report,
    required this.prescriptiontext,
    required this.prescriptionimagepath,
    required this.analysisimagepath,
  });

  @override
  State<ReviewExamination> createState() => _ReviewExaminationState();
}

class _ReviewExaminationState extends State<ReviewExamination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff191D31)),
        title: Center(
          child: Text(
            'Examination',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xff191D31),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 180,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF2F4F7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              widget.doctorImagePath == null ||
                                      widget.doctorImagePath == ""
                                  ? ClipOval(
                                      child: Image.asset(
                                        "assets/images/profile.png",
                                        height: 24,
                                        width: 24,
                                      ),
                                    )
                                  : ClipOval(
                                      child: Image.network(
                                      widget.doctorImagePath ?? "",
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.fill,
                                    )),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Dr :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xff058383)),
                              ),
                              Text(
                                widget.doctorname,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff667085)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Text(
                                "Address :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xff058383)),
                              ),
                              Text(
                                widget.doctoradress,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff667085)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Text(
                                "Date :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xff058383)),
                              ),
                              Text(
                                " ${widget.date}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff667085)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Text(
                                "Patient : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xff058383)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.patientname,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff667085)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Report",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Color(0xff667085)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 160,
                    width: 360,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF2F4F7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.report),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Prescription",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Color(0xff667085)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 160,
                    width: 360,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF2F4F7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.prescriptiontext ?? ""),
                    )),
                widget.prescriptionimagepath == null ||
                        widget.prescriptionimagepath == ""
                    ? Container()
                    : Column(
                        children: [
                          Container(
                            height: 15,
                          ),
                          InteractiveViewer(
                            child: Image.network(widget.prescriptionimagepath??"",

                              width: MediaQuery.of(context).size.width,
                              height:
                              MediaQuery.of(context).size.height / 1.2,
                              fit: BoxFit.fill,),
                          ),
                          Container(
                            height: 15,
                          ),
                        ],
                      ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                widget.analysisimagepath == null
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              Container(
                                height: 15,
                              ),
                              InteractiveViewer(
                                child: Image.file(
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        1.2,
                                    File(
                                      widget.analysisimagepath?[index] ?? "",
                                    )),
                              ),
                              Container(
                                height: 15,
                              ),
                            ],
                          );
                        },
                        itemCount: widget.analysisimagepath?.length ?? 0,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
