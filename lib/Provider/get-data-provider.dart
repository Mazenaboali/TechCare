import 'package:flutter/cupertino.dart';
import 'package:tech_care/database/DoctorDTO.dart';
import 'package:tech_care/data/data%20base/My%20database.dart';
import 'package:tech_care/database/PatientDTO.dart';

class MyDataProvider with ChangeNotifier{

   bool uploadprescriptionState=false;
   bool writeprescriptionState=false;
   PatientDTO? patientdata;
   DoctorDTO? doctordata;

   Future<void> fetchData({required String patientdocument,required String doctordocument})async{
     patientdata=await MyDatabase.getPatientData(patientdocument);
     doctordata =await MyDatabase.getDoctorData(doctordocument);
    notifyListeners();
   }
   Future<void> fetchDoctorData({required String doctordocument})async{
     doctordata =await MyDatabase.getDoctorData(doctordocument);
     notifyListeners();
   }
   Future<void> fetchPatientData({required String patientdocument,})async{
     patientdata=await MyDatabase.getPatientData(patientdocument);
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