import 'package:tech_care/domain/model/Patient.dart';

abstract class PatientRepository{
  Future<void> insertPatient(String email,Patient patient);

}
abstract class PatientDataSource{

  Future<void> insertPatient(String email,Patient patient);
}