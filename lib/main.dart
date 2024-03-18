import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/Patient_or_doctor_screen.dart';
import 'package:tech_care/RegisterScreen/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tech_care/doctor_form.dart';
import 'package:tech_care/patient_form.dart';
import 'HomeScreen/home_screen.dart';
import 'firebase_options.dart';
import 'LoginScreen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('****************User is currently signed out!*************');
      } else {
        print('******************User is signed in!****************');
      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        PatientOrDoctorScreen.routeName: (context) => PatientOrDoctorScreen(),

        PatientFormScreen.routeName: (context) => PatientFormScreen(),

        DoctorFormScreen.routeName: (context) => DoctorFormScreen(),
      },
    );
  }
}
