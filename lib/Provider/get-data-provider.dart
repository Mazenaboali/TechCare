import 'package:flutter/cupertino.dart';
import 'package:tech_care/database/Doctor.dart';
import 'package:tech_care/database/My%20database.dart';
import 'package:tech_care/database/Patient.dart';

class MyDataProvider with ChangeNotifier{

   bool uploadprescriptionState=false;
   bool writeprescriptionState=false;
   Patient? patientdata;
   Doctor? doctordata;

   Future<void> fetchData({required String patientdocument,required String doctordocument})async{
     patientdata=await MyDatabase.getPatientData(patientdocument);
     doctordata =await MyDatabase.getDoctorData(doctordocument);
    notifyListeners();
   }

   void uploadPrescriptionState(){
     uploadprescriptionState=true;
     notifyListeners();
   }

   void writprescriptionState(){
     writeprescriptionState=true;
     notifyListeners();
   }

}