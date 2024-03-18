import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/LoginScreen/login_screen.dart';

class HomeScreen extends StatelessWidget
{
  static String routeName='homeScreen';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context,LoginScreen.routeName);
          }, icon: Icon(Icons.logout))
        ],
        backgroundColor: Colors.red,
        title: Text('TechCare',style: TextStyle(
          color: Colors.white
        ),
        ),


      ),
    );
  }
}