import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/Components/custom_form_field.dart';
import 'package:tech_care/Components/drop_down_button_widget.dart';
import 'package:tech_care/HomeScreen/home_screen.dart';

class DoctorFormScreen extends StatefulWidget {
  static String routeName = "doctorform";

  @override
  State<DoctorFormScreen> createState() => _DoctorFormScreenState();
}

class _DoctorFormScreenState extends State<DoctorFormScreen> {
  TextEditingController phonenumber = TextEditingController();
  String? _genderdropdownvalue = 'Male';
  final _genders = [
    'Male',
    'Female',
  ];
  String? _medicalSpecialtiesdropdownvalue = 'Allergy and Immunology';
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
    'Urology',
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset('assets/images/techCare_background.png',
                      fit: BoxFit.fill),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Patient",
                      style: TextStyle(
                          fontFamily: 'Capriola',
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                        ),
                        Text("Doctor",
                            style: TextStyle(
                                fontFamily: 'Capriola',
                                fontSize: 36,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                        Container(
                          height: 150,
                        ),
                        CustomTextForm(
                          hinttext: 'Phone number',
                          mycontroller: phonenumber,
                          errorvalidationtext:
                          'Pleasiie enter a valid phone number',
                          suffixicon: Icon(
                            Icons.phone,
                            color: Color(0xff023535),
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Gender *',
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                        ),
                        DropdownButton2(
                          icon:
                          Icon(Icons.arrow_drop_down_circle_outlined, size: 27),
                          items: _genders
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff023535),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: _genderdropdownvalue,
                          onChanged: (value) {
                            setState(() {
                              _genderdropdownvalue = value as String;
                            });
                          },
                          iconEnabledColor: Color(0xff023535),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xff023535),
                            ),
                          ),
                          buttonHeight: 60,
                          buttonWidth: 400,
                          buttonPadding: EdgeInsets.all(8),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Specialist *',
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                        ),
                        DropdownButton2(
                          icon:
                          Icon(Icons.arrow_drop_down_circle_outlined, size: 27),
                          items: _medicalSpecialties
                              .map((item) => DropdownMenuItem<String>(
                              value: item, child: DropDownButtonWidget(item)))
                              .toList(),
                          value: _medicalSpecialtiesdropdownvalue,
                          onChanged: (value) {
                            setState(() {
                              _medicalSpecialtiesdropdownvalue = value as String;
                            });
                          },
                          iconEnabledColor: Color(0xff023535),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xff023535),
                            ),
                          ),
                          buttonHeight: 60,
                          buttonWidth: 400,
                          buttonPadding: EdgeInsets.all(8),
                        ),
                        Container(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Container(width: 190,),
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                              },
                              child: Container(

                                decoration:  BoxDecoration(
                                  color:Color(0xff01595B) ,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(

                                  ),
                                ),
                                height: 36,
                                width: 173,

                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(width: 20,),
                                    Text(
                                      'Next',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(width: 25,),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 25,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));



  }
}
