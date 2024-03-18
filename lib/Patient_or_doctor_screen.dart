import 'package:flutter/material.dart';
import 'package:tech_care/doctor_form.dart';
import 'package:tech_care/patient_form.dart';

class PatientOrDoctorScreen extends StatelessWidget {
  static String routeName = "PatientorDoctorscreen";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset('assets/images/techCare_background.png',
              fit: BoxFit.fill),
        ),
        Column(
          children: [
            Container(
              height: 178,
            ),
            Image.asset(
              'assets/images/sticker.png',
              width: 256,
              height: 256,
            ),
            Container(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, PatientFormScreen.routeName);
                },
                color: Color(0xff023535),
                height: 60,
                minWidth: 305,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                //shape: const ShapeBorder(

                //),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Register as a patient",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      'assets/images/patient.png',
                      width: 27,
                      height: 29,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, DoctorFormScreen.routeName);
                },
                color: Color(0xff023535),
                height: 60,
                minWidth: 305,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                     child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Register as a doctor",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      'assets/images/doctor.png',
                      width: 27,
                      height: 29,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
