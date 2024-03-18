import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_care/HomeScreen/home_screen.dart';
import 'package:tech_care/text_field_otp.dart';

class VerficationPhoneScreen extends StatefulWidget {
  String Phonenumber;

  VerficationPhoneScreen({required this.Phonenumber});

  @override
  State<VerficationPhoneScreen> createState() => _VerficationPhoneScreenState();
}

class _VerficationPhoneScreenState extends State<VerficationPhoneScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  TextEditingController c5 = TextEditingController();
  TextEditingController c6 = TextEditingController();

  @override
  void initState() {
    phoneAuthentication();
    StartTimer();
    super.initState();
  }

  int counter = 60;
  bool correct = true;
  String? verifyId;
  void StartTimer() {
    setState(() {
      counter = 30;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.Phonenumber),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFieldOTP(
                  first: true, last: false, controller: c1, correct: correct,context: context),
              TextFieldOTP(
                  first: false, last: false, controller: c2, correct: correct,context: context),
              TextFieldOTP(
                  first: false, last: false, controller: c3, correct: correct,context: context),
              TextFieldOTP(
                  first: false, last: false, controller: c4, correct: correct,context: context),
              TextFieldOTP(
                  first: false, last: false, controller: c5, correct: correct,context: context),
              TextFieldOTP(
                  first: false, last: true, controller: c6, correct: correct,context: context),
            ],
          ),
          Text('$counter'),
          ElevatedButton(onPressed: (){
            CodeSent();
          },
              child: Text('confirm'))
        ],
      ),
    );
  }

  void phoneAuthentication() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2'+widget.Phonenumber,
      timeout: Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        verifyId=verifyId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verifyId=verificationId;
      },
    );
  }
  CodeSent() async{
    try {
      // Update the UI - wait for the user to enter the SMS code
      String smsCode =
          c1.text + c2.text + c3.text + c4.text + c5.text + c6.text;

      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifyId!, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential).then((value) => (){
        if(value.user!=null){
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      });
    } catch (e) {
      setState(() {
        correct=false;
      });
    }
  }
}
