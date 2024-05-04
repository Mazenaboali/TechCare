import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/Components/custom_form_field.dart';
import 'package:tech_care/HomeScreen/patient_home_screen.dart';
import 'package:tech_care/database/My%20database.dart';
import 'package:tech_care/database/Patient.dart';

class PatientFormScreen extends StatefulWidget {
  static String routeName = "patientform";
  final user=FirebaseAuth.instance.currentUser;

   String doctororpatient="patient";

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  TextEditingController phonenumber =TextEditingController();

  TextEditingController Previoussergeries =TextEditingController();

  TextEditingController Medication =TextEditingController();
  TextEditingController dateinput = TextEditingController();

  String? _dropdownvalue = 'Male';
  final _items = [
    'Male',
    'Female',
  ];

  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;
   String chronicdisease="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateinput.text="";
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
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
                        Container(height: 25,),

                        Container(height: 150,),
                        TextFormField(
                          onTap: (){
                            ShowDatepark();
                          },
                          readOnly: true,
                          controller: dateinput,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff023535)),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              suffixIcon: Icon(Icons.calendar_month,size: 30,color: Color(0xff023535)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xff023535)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: Text('Age',
                                style: TextStyle(
                                  color: Color(0xff023535),
                                ),
                              )),
                        ),
                        Container(
                          height: 20,
                        ),
                        CustomTextForm(hinttext: 'Phone number', mycontroller: phonenumber, errorvalidationtext: 'Pleasiie enter a valid phone number',suffixicon: Icon(
                          Icons.phone,
                          color: Color(0xff023535),
                        ),),
                        Container(
                          height: 20,
                        ),
                        TextFormField(
                          minLines: 4,
                          maxLines: 4,
                          controller: Previoussergeries,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff023535)),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xff023535)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: Text('Previous sergeries',
                                style: TextStyle(
                                  color: Color(0xff023535),
                                ),
                              )),
                        ),

                        Container(
                          height: 15,
                        ),
                        TextFormField(
                          minLines: 4,
                          maxLines: 4,
                          controller: Medication,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff023535)),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xff023535)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: Text('Medications',
                                style: TextStyle(
                                  color: Color(0xff023535),
                                ),
                              )),
                        ),
                        Container(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Gender *', style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20
                          ),),
                        ),

                        DropdownButton2(
                          icon: Icon(Icons.arrow_drop_down_circle_outlined,size: 27),
                          items: _items
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:  Color(0xff023535),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: _dropdownvalue,
                          onChanged: (value) {
                            setState(() {
                              _dropdownvalue = value as String;
                            });
                          },

                          iconEnabledColor:  Color(0xff023535),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:  Color(0xff023535),
                            ),
                          ),
                          buttonHeight: 60,
                          buttonWidth: 400,
                          buttonPadding: EdgeInsets.all(8),
                        ),



                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:  Color(0xff023535),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Chronic disease',
                                  style: TextStyle(
                                    color:  Color(0xff023535),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ), // لون النص

                                ),
                                Container(
                                  height: 2,
                                  width: 120,
                                  color:  Color(0xff023535),

                                ),
                                Row(children: [
                                Text(
                                  'Diabse',
                                  style: TextStyle(
                                    color: Color(0xff008F8C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Checkbox(
                                  value:_isChecked1,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked1 = value!;
                                                   
                                      print(_isChecked1);
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ]),
                                Row(children: [
                                  Text(
                                    'Asthma',
                                    style: TextStyle(
                                      color: Color(0xff008F8C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Checkbox(
                                    value:_isChecked2,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked2 = value!;

                                        print(_isChecked2);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ]),
                                Row(children: [
                                  Text(
                                    'Heart disease',
                                    style: TextStyle(
                                      color: Color(0xff008F8C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Checkbox(
                                    value:_isChecked3,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked3 = value!;

                                        print(_isChecked3);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ]),
                                Row(children: [
                                  Text(
                                    'inflammatory bowel',
                                    style: TextStyle(
                                      color: Color(0xff008F8C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Checkbox(
                                    value:_isChecked4,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked4 = value!;
                                        print(_isChecked4);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Container(width: 190,),
                            InkWell(
                              onTap: (){
                                insertPatient();
                                Navigator.pushReplacementNamed(context, PatientHomeScreen.routeName);
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
  String? Age="Birth Date";
  var selectedDate=DateTime.now();
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
        if(DateTime.now().month<selectedDate.month&&DateTime.now().day<selectedDate.day){
          var age=(DateTime.now().year-selectedDate.year)-1;
          dateinput.text= age.toString();
        }
        else{
          var age=(DateTime.now().year-selectedDate.year);
          dateinput.text= age.toString();
        }
      });
    }
}
void insertPatient(){
    if(_isChecked1){
      chronicdisease+="diabse , ";
    }
    if(_isChecked2){
      chronicdisease+="Asthma , ";
    }
    if(_isChecked3){
      chronicdisease+="Heart disease , ";
    }
    if(_isChecked4){
      chronicdisease+="inflammatory bowel , ";
    }
    print("**"+chronicdisease+"**");
    Patient patient=Patient(email: widget.user!.email??"",
        name: widget.user!.displayName??"",
        age: dateinput.text,
        medications: Medication.text,
        chronicdisease: chronicdisease,
        previoussurgeries: Previoussergeries.text,
        phoneumber: phonenumber.text,
        doctororpatient: widget.doctororpatient,
        gender: _dropdownvalue??"");
    MyDatabase.insertPatient(patient.email, patient);
}



}
