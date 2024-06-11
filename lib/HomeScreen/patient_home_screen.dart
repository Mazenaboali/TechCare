import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/Components/custom_button_auth.dart';
import 'package:tech_care/LoginScreen/login_screen.dart';
import 'package:tech_care/Patient/Patient_Profile.dart';
import 'package:tech_care/Patient/Qr%20code%20screen.dart';
import 'package:tech_care/Patient/medical-history-patient-view.dart';
import 'package:tech_care/doctor-profile.dart';
import 'package:tech_care/splash_screen.dart';

class PatientHomeScreen extends StatefulWidget {
  static String routeName = "PatientHomeScreen";
  var user=FirebaseAuth.instance.currentUser;

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xffD9D9D99),
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
                        Navigator.pushReplacementNamed(context, PatientHomeScreen.routeName);
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
                        'assets/images/notification-icon.png',
                        height: 24,
                        width: 24,
                      ),
                      onPressed: () {},
                    ),
                    Text(
                      'Notification',
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
                        Navigator.pushReplacementNamed(context, PatientProfile.routeName);
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
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Welcome !',style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                )),
                Text(widget.user!.displayName??"",style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                )),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
                  ),
                  width: double.infinity,
                  height: 450,
                  child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset('assets/images/percentage-container.png',),
                    ),
                    Container(height: 50,),
                    MaterialButton(
                        onPressed:(){
                               Navigator.pushNamed(context,MedicalHistoryPatientViewScreen.routeName );
                        },
                        child: Container(
                          width: 328,
                          height: 56,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Medical history',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Container(width: 20,),
                                Image.asset('assets/images/medical-history-icon.png',width: 24,height: 24,)
                              ],
                            ),
                          ),
                        )
                    ),
                    Container(height: 50,),
                    MaterialButton(
                        onPressed:(){
                          Navigator.pushNamed(context, QrCodeScreen.routeName);
                        },
                        child: Container(
                          width: 328,
                          height: 56,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Qr Code',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Container(width: 20,),
                                Image.asset('assets/images/scancode-icon.png',width: 24,height: 24,)
                              ],
                            ),
                          ),
                        )
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomButtonAuth(title: 'Log out',onPressed: ()async{

                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context,LoginScreen.routeName);
                    },)
                  ],
                  ),
                )
              ],
            ),
              decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff023535), // Start color
                Color(0xff069B9B), // End color
              ],
            ),
          ))),

    );
  }
}
