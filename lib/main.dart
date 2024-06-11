import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/Doctor/examination-doctor-view.dart';
import 'package:tech_care/HomeScreen/doctor_home_screen.dart';
import 'package:tech_care/Patient/Patient_Profile.dart';
import 'package:tech_care/Patient/Qr%20code%20screen.dart';
import 'package:tech_care/Patient/medical-history-patient-view.dart';
import 'package:tech_care/Patient_or_doctor_screen.dart';
import 'package:tech_care/Provider/get-data-provider.dart';
import 'package:tech_care/RegisterScreen/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tech_care/doctor-profile.dart';
import 'package:tech_care/doctor_form.dart';
import 'package:tech_care/Patient/patient_form.dart';
import 'package:tech_care/examination_form.dart';
import 'package:tech_care/splash_screen.dart';
import 'HomeScreen/patient_home_screen.dart';
import 'firebase_options.dart';
import 'LoginScreen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (buildContext) => MyDataProvider(),
      child: const MyApp()));
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: SplashScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        SplashScreen.routeName:(context)=>SplashScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        PatientHomeScreen.routeName: (context) => PatientHomeScreen(),
        PatientOrDoctorScreen.routeName: (context) => PatientOrDoctorScreen(),
        PatientFormScreen.routeName: (context) => PatientFormScreen(),
        PatientProfile.routeName: (context) => PatientProfile(),
        QrCodeScreen.routeName: (context) => QrCodeScreen(),
        DoctorFormScreen.routeName: (context) => DoctorFormScreen(),
        MedicalHistoryPatientViewScreen.routeName:(context)=>MedicalHistoryPatientViewScreen(),
        ExaminationForm.routeName:(context)=>ExaminationForm(''),
        DoctorProfileScreen.routeName: (context) => DoctorProfileScreen(),
        ExaminationDoctorViewScreen.routeName: (context) => ExaminationDoctorViewScreen(),

        DoctorHomeScreen.routeName: (context) => DoctorHomeScreen(),

      },
    );
  }
}
