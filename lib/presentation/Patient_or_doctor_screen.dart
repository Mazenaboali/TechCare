import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/Doctor/doctor_form.dart';
import 'package:tech_care/Patient/patient_form.dart';

class PatientOrDoctorScreen extends StatelessWidget {
  static String routeName = "PatientorDoctorscreen";
   String username;
   var user=FirebaseAuth.instance.currentUser;
  PatientOrDoctorScreen(this.username);

  @override
  Widget build(BuildContext context) {
    if(username==""){
       username=user?.displayName??"_";
    }
    // TODO: implement build
    return
      Scaffold(
        backgroundColor: Colors.white,
        body:  Column(
            children: [
              Container(
                height: 178,
              ),
              Image.asset(
                'assets/images/sticker.png',
                width: 118,
                height: 105,
              ),
              Container(
                height: 15,
              ),
              Text('Tech care',

                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [
                        Color(0xFF023535),
                        Color(0xFF069B9B),
                      ],
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),

              ),),
              Container(
                height: 30,
              ),
              Text('Let’s get started!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [
                        Color(0xFF023535),
                        Color(0xFF069B9B),
                      ], // Gradient colors
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),

                ),),
              Container(
                height: 10,
              ),
              Text('Login to Stay healthy and fit ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                color: Color(0xffA1A1A1)

                ),),
              Container(
                height: 60,
              ),
              MaterialButton(
                  onPressed:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorFormScreen(name: username)));;
                  },
                  child: Container(

                    width: 328,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(56),
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
                      child: Text('Doctor',
                        style: TextStyle(

                          color: Colors.white,
                          fontSize: 14,

                        ),
                      ),
                    ),
                  )
              ),
              Container(height: 20,),
              MaterialButton(
                  onPressed:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>PatientFormScreen(username)));
                  },
                  child: Container(

                    width: 328,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(56),
                       border: Border.all(color: Color(0xff057878))
                    ),

                    child: Center(
                      child: Text('patient',

                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xff058989),
                          fontSize: 16,


                        ),
                      ),
                    ),
                  )
              ),
            ],
          ),
      );

  }
}
