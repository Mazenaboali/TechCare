class Patient {
  String email;
  String name;
  String age;
  String medications;
  String previoussurgeries;
  String chronicdisease;
  String profileimagepath;
  String phoneumber;
  String doctororpatient;
  String gender;

  Patient({
    this.profileimagepath = "no",
    required this.email,
    required this.name,
    required this.age,
    required this.medications,
    required this.chronicdisease,
    required this.previoussurgeries,
    required this.phoneumber,
    required this.doctororpatient,
    required this.gender
  });

  Patient.FromFirestore(Map<String, dynamic> data)
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
    gender: data['gender']
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
      'gender':gender
    };

  }

}
