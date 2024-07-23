import 'package:tech_care/domain/model/Patient.dart';
import 'package:tech_care/domain/repository/patient-repository-contract.dart';

class PatientRepositoryImpl implements PatientRepository{
  PatientDataSource patientDataSource;

  PatientRepositoryImpl(this.patientDataSource);

  @override
  Future<void> insertPatient(String email, Patient patient) async{
    patientDataSource.insertPatient(email, patient);
  }

}