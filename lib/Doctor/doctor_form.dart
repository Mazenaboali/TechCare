import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_care/Components/custom_button_auth.dart';
import 'package:tech_care/Components/custom_form_field.dart';
import 'package:tech_care/HomeScreen/doctor_home_screen.dart';
import 'package:tech_care/database/Doctor.dart';
import 'package:tech_care/database/My%20database.dart';

class DoctorFormScreen extends StatefulWidget {
  String name;
  var image;
  String? imageUrl;
  DoctorFormScreen({required this.name});

  final _medicalSpecialties = [
    'Allergy and Immunology',
    'Andrology and Male Infertility', // Corrected "Inferility" to "Infertility"
    'Audiology',
    'Cardiology and Thoracic Surgery',
    'Cardiology and Vascular Disease',
    'Chest and Respiratory', // Corrected "abd" to "and"
    'Dentistry', // Corrected "Dentisty"
    'Dermatology',
    'Diabetes and Endocrinology',
    'Diagnostic Radiology',
    'Dietitian and Nutrition', // Removed duplicate with typo "Nutririon"
    'Ear, Nose and Throat',
    'Family Medicine',
    'Gastroenterology and Endoscopy',
    'General Practice',
    'General Surgery',
    'Geriatrics',
    'Gynaecology and Infertility', // Corrected "Infertlilty"
    'Hematology',
    'Hepatology',
    'Internal Medicine',
    'Interventional Radiology',
    'IVF and Infertility', // Corrected "Inferility"
    'Laboratories',
    'Nephrology',
    'Neurology',
    'Neurosurgery',
    'Obesity and Laparoscopic Surgery',
    'Oncology',
    'Oncology Surgery',
    'Ophthalmology',
    'Orthopedics',
    'Osteopathy',
    'Pain Management',
    'Pediatric Surgery',
    'Pediatrics and New Born',
    'Phoniatrics',
    'Physiotherapy and Sport Injuries',
    'Plastic Surgery',
    'Psychiatry',
    'Rheumatology', // Corrected "Theumatology" to "Rheumatology"
    'Spinal Surgery',
  ];
  final _medicalSpecialtiesIcons = [
    'assets/images/drop_down_icon/AllergyandImmunology.png',
    'assets/images/drop_down_icon/Andrology and male infertility.png',
    'assets/images/drop_down_icon/Audiology.png',
    'assets/images/drop_down_icon/Cardiology and Thoracic Surgery.png',
    'assets/images/drop_down_icon/Cardiology and Vascular Disease.png',
    'assets/images/drop_down_icon/Chest and Respiratory.png',
    'assets/images/drop_down_icon/Dentistry.png',
    'assets/images/drop_down_icon/Dermatology.png',
    'assets/images/drop_down_icon/Diabetes and Endocrinology.png',
    'assets/images/drop_down_icon/Diagnostic Radiology.png',
    'assets/images/drop_down_icon/Dietitian and Nutrition.png',
    'assets/images/drop_down_icon/Ear, Nose and Throat.png',
    'assets/images/drop_down_icon/Family Medicine.png',
    'assets/images/drop_down_icon/Gastroenterology and Endoscopy.png',
    'assets/images/drop_down_icon/General Practice.png',
    'assets/images/drop_down_icon/General Surgery.png',
    'assets/images/drop_down_icon/Geriatrics.png',
    'assets/images/drop_down_icon/Gynaecology and Infertility.png',
    'assets/images/drop_down_icon/Hematology.png',
    'assets/images/drop_down_icon/Hepatology.png',
    'assets/images/drop_down_icon/Internal Medicine.png',
    'assets/images/drop_down_icon/Interventional Radiology.png',
    'assets/images/drop_down_icon/IVF and Infertility.png',
    'assets/images/drop_down_icon/Laboratories.png',
    'assets/images/drop_down_icon/Nephrology.png',
    'assets/images/drop_down_icon/Neurology.png',
    'assets/images/drop_down_icon/Neurosurgery.png',
    'assets/images/drop_down_icon/Obesity and Laparoscopic Surgery.png',
    'assets/images/drop_down_icon/Oncology.png',
    'assets/images/drop_down_icon/Oncology Surgery.png',
    'assets/images/drop_down_icon/Ophthalmology.png',
    'assets/images/drop_down_icon/Orthopedics.png',
    'assets/images/drop_down_icon/Pain Management.png',
    'assets/images/drop_down_icon/Pediatric Surgery.png',
    'assets/images/drop_down_icon/Pediatrics and New Born.png',
    'assets/images/drop_down_icon/Phoniatrics.png',
    'assets/images/drop_down_icon/Physiotherapy and Sport Injuries.png',
    'assets/images/drop_down_icon/Plastic Surgery.png',
    'assets/images/drop_down_icon/Psychiatry.png',
    'assets/images/drop_down_icon/Rheumatology.png',
    'assets/images/drop_down_icon/Spinal Surgery.png',
    'assets/images/drop_down_icon/Urology.png'
  ];
  String profileimagepath="";
  static String routeName = "doctorform";
  var user=FirebaseAuth.instance.currentUser;
  String doctororpatient='doctor';
  @override
  State<DoctorFormScreen> createState() => _DoctorFormScreenState();
}

class _DoctorFormScreenState extends State<DoctorFormScreen> {
  TextEditingController phonenumber = TextEditingController();

  TextEditingController dateinput = TextEditingController();
  TextEditingController adress = TextEditingController();

  TextEditingController careerpath = TextEditingController();

  TextEditingController about = TextEditingController();

  TextEditingController experience = TextEditingController();


  TextEditingController available = TextEditingController();
  String _genderdropdownvalue = 'Male';
  final _genders = [
    'Male',
    'Female',
  ];
  String _medicalSpecialtiesdropdownvalue = 'Allergy and Immunology';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        widget.profileimagepath == ""
                            ? ClipOval(
                          child: Image.asset(
                            "assets/images/profile.png",
                            height: 110,
                            width: 110,
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                              child: Image.network(widget.imageUrl!,width: 155,height: 155,fit: BoxFit.fill,)
                          ),
                        ),
                        Container(height: 10,),
                        Container(
                          width: 107,
                          height: 42,
                          child: MaterialButton(
                            onPressed: () {
                              uploadImage();
                            },
                            child: Row(
                              children: [
                                Image.asset('assets/images/gallery-icon.png',width: 20,height: 20,),
                                Container(width: 10,),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(0xff7A7979),
                                  ),
                                ),
                              ],
                            ),
                            color: Colors.white,
                            height: 42,
                            minWidth: 107,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Color(0xFF1EAFB3), width: 1),
                            borderRadius: BorderRadius.circular(26),
                          ),
                        )
                      ],
                    ),
                  ],
                ),


                Container(
                  height: 20,
                ),
                Text(
                  " Phone number",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff667085)),
                ),
                CustomTextForm(
                  hinttext: 'Phone number',
                  mycontroller: phonenumber,
                  errorvalidationtext:
                      'Please enter a valid phone number',
                ),
                Container(
                  height: 20,
                ),
                Text(
                  "  Age",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff667085)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F4F7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFFEAECF0),
                      width: 1,
                    ),
                  ),
                  child: TextFormField(
                    onTap: () {
                      ShowDatepark();
                    },
                    readOnly: true,
                    controller: dateinput,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      hintText: 'Select ',
                      hintStyle: TextStyle(
                        color: Color(0xff667085),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xFFF2F4F7)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: Color(0xff292D32),
                        size: 20,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF2F4F7),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Color(0xFFF2F4F7)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Text(
                  "  Gender",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff667085)),
                ),
                Container(
                  width: screenWidth,
                  height: 60,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F4F7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFFEAECF0),
                      width: 1,
                    ),
                  ),
                  child: DropdownButton<String>(
                    items: _genders
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Row(
                        children: [
                          Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff667085),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            width: screenWidth-128,
                          )
                        ],
                      ),
                    ))
                        .toList(),
                    value: _genderdropdownvalue,
                    onChanged: (value) {
                      setState(() {
                        _genderdropdownvalue = value!;
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_down_sharp, size: 20),
                    iconEnabledColor: Color(0xff023535),
                    underline: Container(),
                    style: TextStyle(
                        fontSize: 16, color: Color(0xff023535)),
                    itemHeight: 48,
                    isDense: true,
                    dropdownColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "  About",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff667085)),
                ),
                CustomTextForm(
                  hinttext: 'Write a brief overview about you',
                  mycontroller: about,
                  minLines: 4,
                  maxLines: 4,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "  Career path",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff667085)),
                ),
                CustomTextForm(
                  hinttext: 'Enter your career path',
                  mycontroller: careerpath,
                  minLines: 4,
                  maxLines: 4,
                ),
                Text(
                  "  Specialist",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff667085)),
                ),
                DropdownButton2(
                  icon:
                  Icon(Icons.keyboard_arrow_down_sharp, size: 20),
                  value:_medicalSpecialtiesdropdownvalue ,
                  items: widget._medicalSpecialties.asMap().entries.map((entry) {
                    int index = entry.key;
                    String item = entry.value;
                    return DropdownMenuItem(
                        value: item,
                        child:  Row(
                          children: [
                            Image.asset(widget._medicalSpecialtiesIcons[index],width: 20,height:20 ,),
                            Container(width: 10,),
                            Text(
                             item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color:  Color(0xff667085),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        // Pass the index to your widget
                        );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _medicalSpecialtiesdropdownvalue = value as String;
                    });
                  },
                  buttonDecoration: BoxDecoration(
                    color: Color(0xffF2F4F7),
                    border: Border.all(color: Color(0xffEAECF0)),
                    borderRadius: BorderRadius.circular(8)
                  ),

                  buttonHeight: 60,
                  buttonWidth: 400,

                  buttonPadding: EdgeInsets.all(8),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "  Experience",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff667085)),
                ),
                CustomTextForm(
                  hinttext: 'Enter the number of experience years',
                  mycontroller: experience,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "  Adress",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff667085)),
                ),
                CustomTextForm(
                  hinttext: 'Enter your address',
                  mycontroller: adress,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "  Available",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff667085)),
                ),
                CustomTextForm(
                  hinttext: 'Enter your clinic opening hours',
                  mycontroller: available,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButtonAuth(title: 'Save',onPressed: (){
                  insertDoctor();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorHomeScreen()
                  )
                  );
                },)
              ],
            ),
          ),
        ));
  }
  void insertDoctor(){
    Doctor doctor=Doctor(email: widget.user?.email??"",
        name:widget.name ,
        phonenumber:phonenumber.text ,
        specialist: _medicalSpecialtiesdropdownvalue,
        adress: adress.text,
        gender: _genderdropdownvalue,
        doctororpatient: widget.doctororpatient,
        about: about.text,
        profileimagepath: widget.profileimagepath,
        available: available.text,
        careerpath: careerpath.text,
        experience: experience.text
    );
    MyDatabase.insertDoctor(widget.user?.email??" ", doctor);
  }

  String? Age = "Birth Date";
  var selectedDate = DateTime.now();
  void ShowDatepark() async {
    var userSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.fromMillisecondsSinceEpoch(-1446429609000),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (userSelectedDate == null) {
      return;
    } else {
      selectedDate = userSelectedDate;
      setState(() {
        if (DateTime.now().month < selectedDate.month &&
            DateTime.now().day < selectedDate.day) {
          var age = (DateTime.now().year - selectedDate.year) - 1;
          dateinput.text = age.toString();
        } else {
          var age = (DateTime.now().year - selectedDate.year);
          dateinput.text = age.toString();
        }
      });
    }
  }


  void uploadImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        widget.image = File(pickedImage.path);
      });
      try {

        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
        final uploadTask = firebaseStorageRef.putFile(widget.image!);

        final snapshot = await uploadTask.whenComplete(() {});

        if (snapshot.state == TaskState.success) {
          final downloadURL = await snapshot.ref.getDownloadURL();
          widget.imageUrl=downloadURL;
          setState(() {

          });
        } else {
          widget.imageUrl=null;
          setState(() {

          });
        }
      } catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('uploading image failed')));
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('no images selected')));
    }
    print(widget.imageUrl);

  }

}
