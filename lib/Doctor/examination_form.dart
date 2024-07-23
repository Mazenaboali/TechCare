import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/Provider/get-data-provider.dart';
import 'package:tech_care/data/data%20base/My%20database.dart';
import 'package:tech_care/database/examinationDTO.dart';
import 'package:tech_care/domain/utils/dialog_utils.dart';
import 'package:tech_care/presentation/Components/dash-border-button.dart';

import '../Provider/get-data-provider.dart';

class ExaminationForm extends StatefulWidget {
  static String routeName = "Examination form";
  var user = FirebaseAuth.instance.currentUser;
  var image;
  String qrcoderesult;
  String? prescriptionimage;
  String? doctorname;
  String? patientimagepath;
  String? doctorimagepath;
  String? doctoradress;
  String? patientname;
  String dateTime = DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString() +
      "   " +
      DateTime.now().hour.toString();
  ExaminationForm(this.qrcoderesult);

  @override
  State<ExaminationForm> createState() => _ExaminationFormState();
}

class _ExaminationFormState extends State<ExaminationForm> {
  TextEditingController report = TextEditingController();
  TextEditingController prescription = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.qrcoderesult);
    print(user?.email ?? "");
    Provider.of<MyDataProvider>(context, listen: false).fetchData(
        doctordocument: user?.email ?? "",
        patientdocument: widget.qrcoderesult);
  }

  var user = FirebaseAuth.instance.currentUser;
  @override
  build(BuildContext context) {
    var myDataProvider = Provider.of<MyDataProvider>(context);
    widget.doctorname = myDataProvider.doctordata?.name;
    widget.patientname = myDataProvider.patientdata?.name;
    widget.doctoradress = myDataProvider.doctordata?.adress;
    widget.doctorimagepath = myDataProvider.doctordata?.profileimagepath;
    widget.patientimagepath = myDataProvider.patientdata?.profileimagepath;

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
              onTap: () {
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
                              widget.doctorimagepath == null || widget.doctorimagepath==""
                                  ? ClipOval(
                                child: Image.asset(
                                  "assets/images/profile.png",
                                  height: 24,
                                  width: 24,
                                ),
                              )
                                  : ClipOval(
                                  child: Image.network(widget.doctorimagepath??"",width: 24,height: 24,fit: BoxFit.fill,)
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
                                myDataProvider.doctordata?.name ?? "_",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff667085)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                myDataProvider.doctordata?.specialist ?? "_",
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
                                myDataProvider.doctordata?.adress ?? "_",
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
                                myDataProvider.patientdata?.name ?? "",
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
                      hintStyle: TextStyle(
                          color: Color(0xff667085),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2F4F7)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffEAECF0)),
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
                    onPressed: () async {
                      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

                      if (pickedImage != null) {
                        setState(() {
                          widget.image = File(pickedImage.path);
                        });
                        try {

                          final fileName = DateTime.now().millisecondsSinceEpoch.toString();
                          final firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
                          final uploadTask = firebaseStorageRef.putFile(widget.image!);

                          final snapshot = await uploadTask.whenComplete(() {});

                          if (snapshot.state == TaskState.success) {
                            final downloadURL = await snapshot.ref.getDownloadURL();
                            widget.prescriptionimage=downloadURL;
                            print(widget.prescriptionimage);
                            print('sossososo');

                          } else {
                            widget.prescriptionimage=null;

                          }
                        } catch (ex) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('uploading image failed')));
                        }
                        setState(() {
                          myDataProvider.uploadPrescriptionState();
                        });
                      }
                      else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('no images selected')));
                      }
                    },
                  ),
                ),
                myDataProvider.uploadprescriptionState == false ||
                        widget.prescriptionimage == null
                    ? Container()
                    : Column(
                        children: [
                          Container(
                            height: 15,
                          ),
                          InteractiveViewer(
                            child: Image.network(widget.prescriptionimage!,

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
                myDataProvider.writeprescriptionState == false
                    ? Container()
                    : Column(
                        children: [
                          Container(
                            height: 15,
                          ),
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
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F4F7)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffEAECF0)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 15,
                          ),
                        ],
                      ),
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

  void insertExamination() {
    DateTime dateTime = DateTime.now();
    if (dateTime.hour < 12) {
      widget.dateTime += 'AM';
    } else {
      widget.dateTime += 'PM';
    }
    ExaminationDTO examination = ExaminationDTO(
        doctorname: widget.doctorname ?? "",
        doctoradress: widget.doctoradress ?? "",
        date: widget.dateTime,
        patientname: widget.patientname ?? "",
        report: report.text,
        doctoremail: user?.email ?? "",
        prescriptionimagepath: widget.prescriptionimage,
        prescriptiontext: prescription.text,
        patientimagepath: widget.patientimagepath,
        doctorimagepath: widget.doctorimagepath,
        patientemail: widget.qrcoderesult);
    MyDatabase.insertPatientExamination(
        'patient', widget.qrcoderesult, examination);

    MyDatabase.insertPatientExamination(
        'doctor', user?.email ?? "", examination);
    dialogUtils.showMessage(context, 'Examination was added successfully',
      posaction: 'ok'
    );
  }




}

