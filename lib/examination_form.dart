import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/Components/custom_button_auth.dart';
import 'package:tech_care/Provider/get-data-provider.dart';
import 'package:tech_care/database/My%20database.dart';
import 'package:tech_care/database/examination.dart';
import 'package:tech_care/utils/date%20utils.dart';

import 'Provider/get-data-provider.dart';

class ExaminationForm extends StatefulWidget {
  static String routeName = "Examination form";
var user=FirebaseAuth.instance.currentUser;
  String qrcoderesult = "";
  String? prescriptionimage;
  String? doctorname;
  String? patientimagepath;
  String? doctorimagepath;
  String? doctoradress;
  String? patientname;
  String dateTime=DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString()+"   "+DateTime.now().hour.toString();
  ExaminationForm(this.qrcoderesult);




  @override
  State<ExaminationForm> createState() => _ExaminationFormState();
}

class _ExaminationFormState extends State<ExaminationForm> {
  TextEditingController report=TextEditingController();
  TextEditingController prescription=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MyDataProvider>(context,listen: false).fetchData(
        doctordocument: user?.email ?? "",
        patientdocument: widget.qrcoderesult);

  }

  var user = FirebaseAuth.instance.currentUser;
  @override
  build(BuildContext context) {
    var myDataProvider = Provider.of<MyDataProvider>(context);
    widget.doctorname=myDataProvider.doctordata?.name;
    widget.patientname=myDataProvider.patientdata?.name;
    widget.doctoradress=myDataProvider.doctordata?.adress;
    widget.doctorimagepath=myDataProvider.doctordata?.profileimagepath;
    widget.patientimagepath=myDataProvider.patientdata?.profileimagepath;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff191D31)),
        title: Center(
          child: Text(
            'Examinations',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xff191D31),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                insertExamination();
              },
              child: Container(
                child: Image.asset(
                  "assets/images/save-icon.png",
                  height: 27,
                  width: 27,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 480,
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
                              ClipOval(
                                child: Image.asset(
                                  "assets/images/profile.png",
                                  height: 27,
                                  width: 27,
                                ),
                              ),
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
                                myDataProvider.doctordata?.name??"_",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff667085)),
                              ),
                              SizedBox(
                                width: 90,
                              ),
                              Text(
                                myDataProvider.doctordata?.specialist??"_",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff058383)),
                              ),
                            ],
                          ),
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
                                myDataProvider.doctordata?.adress??"_",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff667085)),
                              ),
                            ],
                          ),
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
                                  widget.dateTime,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff667085)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Text(
                                "Patient :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xff058383)),
                              ),
                              Text(
                                myDataProvider.patientdata?.name??"",
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
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
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
                  height: 7,
                ),
                Container(
                  height: 150,
                  width: 480,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF2F4F7),
                  ),
                  child: TextFormField(
                    controller: report,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Input',
                        hintStyle:TextStyle(
                            color: Color(0xff667085),
                            fontSize: 14,
                            fontWeight: FontWeight.w400) ,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF2F4F7)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffEAECF0)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [

                      Text(
                        "Use camera to Upload the prescription",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff667085)),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 7,
                ),
                Center(
                  child: DashedBorderButton(
                    width: 370,
                    height: 50,
                    borderRadius: 24,
                    borderColor: Color(0xFF058383),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                          ),
                          Image.asset(
                            "assets/images/upload-icon.png",
                            height: 27,
                            width: 27,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Upload Prescription',
                            style: TextStyle(color: Color(0xFF058383)),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async{
                      ImagePicker picker = ImagePicker();
                      final pickedFile = await picker.pickImage(source: ImageSource.camera);
                      XFile? xfilePick = pickedFile;
                      if (xfilePick != null) {
                        widget.prescriptionimage=xfilePick.path;
                        print("${widget.prescriptionimage}**mazoona");
                      }
                       myDataProvider.uploadPrescriptionState();
                       print(myDataProvider.uploadprescriptionState);
                    },
                  ),
                ),
                myDataProvider.uploadprescriptionState==false || widget.prescriptionimage==null? Container():
                    Column(
                      children: [
                      Container(height: 15,),
                        InteractiveViewer(

                          child: Image.file(
                               fit: BoxFit.fill,

                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/1.2,
                              File(
                                widget.prescriptionimage??"",
                              )),
                        ),
                        Container(height: 15,),

                      ],
                    ),

                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Write the prescription manually",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff667085)),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: DashedBorderButton(
                    width: 370,
                    height: 50,
                    borderRadius: 24,
                    borderColor: Color(0xFF058383),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                          ),
                          Image.asset(
                            "assets/images/prescription-icon.png",
                            height: 27,
                            width: 27,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Write Prescription',
                            style: TextStyle(color: Color(0xFF058383)),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      myDataProvider.writprescriptionState();
                    },
                  ),
                ),
                  myDataProvider.writeprescriptionState==false?Container():
                      Column(children: [
                        Container(height: 15,),
                        Container(
                          height: 170,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffF2F4F7),
                          ),
                          child: TextFormField(
                            controller: prescription,
                            maxLines: 4,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'R/',
                              hintStyle: TextStyle(
                                  color: Color(0xff667085),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFF2F4F7)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Color(0xffEAECF0)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Container(height: 15,),
                      ],),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  void insertExamination(){
    DateTime dateTime = DateTime.now();

    if (dateTime.hour < 12) {
      widget.dateTime+='AM';
    } else {
      widget.dateTime+='PM';
    }
        Examination examination=Examination(doctorname: widget.doctorname??"",
            doctoradress: widget.doctoradress??"",
            date: widget.dateTime,
            patientname: widget.patientname??"",
            report: report.text,
            doctoremail: user?.email ??"",
            prescriptionimagepath: widget.prescriptionimage,
            prescriptiontext: prescription.text,
            patientimagepath: widget.patientimagepath,
            doctorimagepath: widget.doctorimagepath,
            patientemail: widget.qrcoderesult);
        MyDatabase.insertPatientExamination('patient',widget.qrcoderesult, examination);
  }
}

class DashedBorderButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final Widget child;
  final VoidCallback onPressed;

  const DashedBorderButton({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.borderColor,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: CustomPaint(
          size: Size(width, height),
          painter: DashedBorderPainter(
            borderRadius: borderRadius,
            borderColor: borderColor,
          ),
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final double borderRadius;
  final Color borderColor;

  DashedBorderPainter({
    required this.borderRadius,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = borderColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final double dashWidth = 5.0;
    final double dashSpace = 3.0;
    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final Path dashedPath = Path();
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashedPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;


}
