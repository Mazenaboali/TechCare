import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/data/data%20base/My%20database.dart';
import 'package:tech_care/data/model/PatientDTO.dart';
import 'package:tech_care/presentation/HomeScreen/doctor_home_screen.dart';
import 'package:tech_care/presentation/HomeScreen/patient_home_screen.dart';
import 'package:tech_care/presentation/LoginScreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "Splash Screen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<PatientDTO?>(
        future: MyDatabase.getPatientData(user?.email ?? " "),
        builder: (buildContext, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/splash-screen.png"),
                ),
              ),
            );
          }
          var data = snapshot.data;
          if (user == null) {
            return LoginScreen();
          }
          if (snapshot.hasError) {
            return Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('try again'),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/splash-screen.png"),
                ),
              ),
            );
          }
          if (data?.doctororpatient == 'patient') {
            return PatientHomeScreen();
          }
          print(snapshot.data);
          return DoctorHomeScreen();
        });
  }
}
