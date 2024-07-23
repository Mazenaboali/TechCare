class PatientDTO {
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


  PatientDTO({
    this.profileimagepath,
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
    required this.bloodtype
  });

  PatientDTO.FromFirestore(Map<String, dynamic> data)
      : this(
    email: data['email'],
    name: data['name'],
    age: data['age'],
    medications: data['medications'],
    previoussurgeries: data['previoussurgeries'],
    chronicdisease: data['chronicdisease'],
    profileimagepath: data['profileimagepath'],
    phoneumber: data['phoneumber'],
    doctororpatient: data['doctororpatient'],
    gender: data['gender'],
    bloodtype: data['bloodtype'],
    height: data['height'],
    weight: data['weight']
  );

   Map<String, dynamic> ToFirestore() {
    return {
      'email': email,
      'name': name,
      'age': age,
      'medications': medications,
      'previoussurgeries': previoussurgeries,
      'chronicdisease': chronicdisease,
      'profileimagepath': profileimagepath,
      'phoneumber': phoneumber,
      'doctororpatient': doctororpatient,
      'gender':gender,
      'bloodtype':bloodtype,
      'height':height,
      'weight':weight
    };

  }

}
