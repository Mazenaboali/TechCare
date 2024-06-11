class Doctor {
  String? email;
  String? name;
  String? phonenumber;
  String? specialist;
  String? adress;
  String? gender;
  String? doctororpatient;

  String? about;
  String? experience;
  String? careerpath;
  String? available;
  String? profileimagepath;

  Doctor({
    this.profileimagepath,
    required this.email,
    required this.name,
    required this.phonenumber,
    required this.specialist,
    required this.adress,
    required this.gender,
    required this.doctororpatient,
    required this.about,
    required this.experience,
    required this.careerpath,
    required this.available,
  });

  Doctor.FromFirestore(Map<String, dynamic> data)
      : this(
            email: data['email'],
            name: data['name'],
            phonenumber: data['phonenumber'],
            specialist: data['specialist'],
            adress: data['adress'],
            gender: data['gender'],
            doctororpatient: data['doctororpatient'],
            about: data['about'],
            experience: data['experience'],
            careerpath: data['careerpath'],
            available: data['available'],
            profileimagepath: data['profileimagepath']);

  Map<String, dynamic> ToFirestore() {
    return {
      'email': email,
      'name': name,
      'phonenumber': phonenumber,
      'doctororpatient': doctororpatient,
      'gender': gender,
      'adress': adress,
      'specialist': specialist,
      'about': about,
      'experience': experience,
      'careerpath': careerpath,
      'available': available,
      'profileimagepath': profileimagepath
    };
  }
}
