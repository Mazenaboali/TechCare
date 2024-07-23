import 'package:tech_care/domain/model/Patient.dart';
import 'package:tech_care/domain/repository/patient-repository-contract.dart';

class InsertPatientUseCase{
  PatientRepository patientRepository;
  InsertPatientUseCase(this.patientRepository);
  Future<void> Invoke(String email,Patient patient)async{
       await patientRepository.insertPatient(email, patient);
  }
}