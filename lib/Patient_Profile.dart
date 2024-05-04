
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_care/Qr%20code%20screen.dart';
import 'package:tech_care/database/My%20database.dart';
import 'package:tech_care/database/Patient.dart';

class PatientProfile extends StatefulWidget {
  static String routeName = "PatientProfile";
  var user = FirebaseAuth.instance.currentUser;
  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Patient?>(
        future: MyDatabase.getPatientData(widget.user!.email ?? ""),
        builder: (buildContext, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                        "assets/images/Patient-profile-background.jpg"),
                  ),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          }
          var data = snapshot.data;
          if (snapshot.hasError) {
            return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                        "assets/images/Patient-profile-background.jpg"),
                  ),
                ),
                child: Text('Error Loading data'));
          }
          return Scaffold(
              body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image:
                    AssetImage("assets/images/Patient-profile-background.jpg"),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          data?.profileimagepath == "no"
                              ? InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/profile-photo.png",
                                      height: 155,
                                      width: 155,
                                    ),
                                  ))
                              : InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: ClipOval(
                                    child: Image.file(
                                      fit: BoxFit.fill,
                                        height: 105,
                                        width: 105,
                                       File(data!.profileimagepath,
                                       )
                                    )
                                  )),
                          Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: Text(
                              data?.name ?? "_",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              width: 97,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Age",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xff023535)),
                                      ),
                                      Text(
                                        data?.age ?? "_",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xff01595B)),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 70,
                              width: 212,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Text(
                                      "phone number",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Color(0xff023535)),
                                    ),
                                    Text(
                                      data?.phoneumber ?? "_",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Color(0xff01595B)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 105,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(
                                  "Chronic Disease",
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff023535)),
                                ),
                                Text(
                                  data?.chronicdisease ?? "_",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff01595B)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(
                                  "Medication",
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff023535)),
                                ),
                                Text(
                                  data?.medications ?? "_",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff01595B)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 80,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(
                                  "Previous surgeries",
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff023535)),
                                ),
                                Text(
                                  data?.previoussurgeries ?? "_",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff01595B)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, QrCodeScreen.routeName);
                          },
                          color: Color(0xff01595B),
                          height: 36,
                          minWidth: 173,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Your QR Code",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        });
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    XFile? xfilePick = pickedFile;
    if (xfilePick != null) {
      FirebaseFirestore.instance
          .collection('patient')
          .doc(widget.user?.email ?? "")
          .update({'profileimagepath': xfilePick.path});
    }
    setState(() {});
  }
}
