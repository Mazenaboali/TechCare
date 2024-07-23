import 'package:tech_care/data/data%20base/My%20database.dart';
import 'package:tech_care/domain/model/Patient.dart';
import 'package:tech_care/domain/repository/patient-repository-contract.dart';

class PatientFirestoreDataSource implements PatientDataSource
{
  MyDatabase myDatabase;

  PatientFirestoreDataSource(this.myDatabase);

  @override
  Future<void> insertPatient(String email, Patient patient) async{

     myDatabase.insertPatient(email, patient.toDTO());

  }

}