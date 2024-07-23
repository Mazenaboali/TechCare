import 'package:tech_care/database/PatientDTO.dart';

class Patient {
  String? email;
  String? name;
  String? age;
  String? medications;
  String? previoussurgeries;
  String? chronicdisease;
  String? profileimagepath;
  String? phoneumber;
  String? doctororpatient;
  String? gender;
  String? weight;
  String? height;
  String? bloodtype;

  Patient(
      {this.profileimagepath,
      required this.email,
      required this.name,
      required this.age,
      required this.medications,
      required this.chronicdisease,
      required this.previoussurgeries,
      required this.phoneumber,
      required this.doctororpatient,
      required this.gender,
      required this.height,
      required this.weight,
      required this.bloodtype});

  PatientDTO toDTO() {
    return PatientDTO(
        email: email,
        name: name,
        age: age,
        medications: medications,
        chronicdisease: chronicdisease,
        previoussurgeries: previoussurgeries,
        phoneumber: phoneumber,
        doctororpatient: doctororpatient,
        gender: gender,
        height: height,
        weight: weight,
        bloodtype: bloodtype);
  }
}
