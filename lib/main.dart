import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/presentation/Doctor/doctor-profile.dart';
import 'package:tech_care/presentation/Doctor/examination-doctor-view.dart';
import 'package:tech_care/presentation/Doctor/medical-history-of-the-patient-with-other-doctor.dart';
import 'package:tech_care/presentation/Patient/Patient_Profile.dart';
import 'package:tech_care/presentation/Patient/Qr%20code%20screen.dart';
import 'package:tech_care/presentation/Patient/medical-history-patient-view.dart';
import 'package:tech_care/domain/get-data-provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tech_care/presentation/Doctor/doctor_form.dart';
import 'package:tech_care/presentation/Patient/patient_form.dart';
import 'package:tech_care/presentation/Doctor/examination_form.dart';
import 'package:tech_care/presentation/splash_screen.dart';
import 'firebase_options.dart';
import 'presentation/HomeScreen/doctor_home_screen.dart';
import 'presentation/HomeScreen/patient_home_screen.dart';
import 'presentation/LoginScreen/login_screen.dart';
import 'presentation/Patient_or_doctor_screen.dart';
import 'presentation/RegisterScreen/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (buildContext) => MyDataProvider(), child: const MyApp()));
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
        SplashScreen.routeName: (context) => SplashScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        PatientHomeScreen.routeName: (context) => PatientHomeScreen(),
        PatientOrDoctorScreen.routeName: (context) => PatientOrDoctorScreen(''),
        PatientFormScreen.routeName: (context) => PatientFormScreen(''),
        PatientProfile.routeName: (context) => PatientProfile(),
        QrCodeScreen.routeName: (context) => QrCodeScreen(),
        DoctorFormScreen.routeName: (context) => DoctorFormScreen(name: ''),
        MedicalHistoryPatientViewScreen.routeName: (context) =>
            MedicalHistoryPatientViewScreen(),
        ExaminationForm.routeName: (context) => ExaminationForm(''),
        DoctorProfileScreen.routeName: (context) => DoctorProfileScreen(),
        ExaminationDoctorViewScreen.routeName: (context) =>
            ExaminationDoctorViewScreen(),
        MedicalHistoryOfThePatientWithOtherDoctorScreen.routeName: (context) =>
            MedicalHistoryOfThePatientWithOtherDoctorScreen(qrcoderesult: ''),
        DoctorHomeScreen.routeName: (context) => DoctorHomeScreen(),
      },
    );
  }
}
