
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/domain/dependency_injection.dart';
import 'package:tech_care/domain/model/Patient.dart';
import 'package:tech_care/domain/utils/validation_utils.dart';
import 'package:tech_care/presentation/Components/custom_button_auth.dart';
import 'package:tech_care/presentation/Components/custom_form_field.dart';
import 'package:tech_care/presentation/HomeScreen/patient_home_screen.dart';
import 'package:tech_care/presentation/Patient/Patient_form_view_model.dart';

class PatientFormScreen extends StatefulWidget {
  static String routeName = "PatientFormScreen";
  String name;
  PatientFormScreen(this.name);


  String doctororpatient = "patient";

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {

  var formKey=GlobalKey<FormState>();
  TextEditingController phonenumber = TextEditingController();

  TextEditingController Previoussergeries = TextEditingController();
  TextEditingController weight = TextEditingController();

  TextEditingController height = TextEditingController();
  TextEditingController Medication = TextEditingController();
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;

  String? _dropdownGendervalue = 'Male';
  final _items = [
    'Male',
    'Female',
  ];

  String? _bloodtypevalue = 'A+';
  final _bloodtypeitems = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB', 'AB+'];


  PatientFormViewModel viewModel =PatientFormViewModel(loginUseCase: LoginUseCaseInjection(),
    insertPatientUseCase: PatientUseCaseInjection(),

  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.dateinput.text="";
  }
  @override
  Widget build(BuildContext context) {
    false;
    return ChangeNotifierProvider(
      create: (_)=> viewModel,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xff191D31)),
          title: Text(
            'Edit Personal data',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xff191D31),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<PatientFormViewModel>(
                builder: (context,viewModel,child){
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      viewModel.imageUrl == "" ||viewModel.imageUrl==null
                          ? ClipOval(
                        child: Image.asset(
                          "assets/images/profile.png",
                          height: 155,
                          width: 155,
                        ),
                      )
                          : InkWell(
                          onTap: () {
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipOval(
                                child: Image.network(viewModel.imageUrl!,width: 155,height: 155,fit: BoxFit.fill,)
                            ),
                          )
                      ),
                      Container(
                        width: 107,
                        height: 42,
                        child: MaterialButton(
                          onPressed: () {
                            viewModel.uploadImage(context);
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          padding: EdgeInsets.zero,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "  Phone number",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff667085)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 328,
                                  height: 48,
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF2F4F7),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFF2F4F7),
                                      width: 1,
                                    ),
                                  ),
                                  child: TextFormField(
                                    validator: (text) {
                                      if (text == null || text.trim().isEmpty) {
                                        return 'Please enter a phone number';
                                      }
                                      if (!ValidationUtils.isValidEmail(text)) {
                                        return 'Please enter a valid email or Phone number';
                                      }
                                      return null;
                                    },
                                    onTap: () {},
                                    controller: phonenumber,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: 'Phone number',
                                      hintStyle: TextStyle(
                                        color: Color(0xff667085),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xFFF2F4F7)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        const BorderSide(color: Color(0xffEAECF0)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
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
                                  width: 328,
                                  height: 48,
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
                                    validator: (text) {
                                      if (text == null || text.trim().isEmpty) {
                                        return 'Please enter your age ';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      viewModel.ShowDatepark(context);
                                    },
                                    readOnly: true,
                                    controller: viewModel.dateinput,
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
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "  Gender",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff667085)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 300,
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
                                    items: _items
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
                                            width: 230,
                                          )
                                        ],
                                      ),
                                    ))
                                        .toList(),
                                    value: _dropdownGendervalue,
                                    onChanged: (value) {
                                      setState(() {
                                        _dropdownGendervalue = value!;
                                      });
                                    },
                                    icon:
                                    Icon(Icons.keyboard_arrow_down_sharp, size: 20),
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
                                  "  Weight",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff667085)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomTextForm(
                                  errorvalidationtext: 'please enter you weight ',
                                  hinttext: 'Enter your weight', mycontroller: weight,),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "  Height",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff667085)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomTextForm(
                                  errorvalidationtext: 'please enter your height',
                                  hinttext: 'Enter your height', mycontroller: height,),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "  What is your blood type",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff667085)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 300,
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
                                    items: _bloodtypeitems
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
                                            width: 230,
                                          )
                                        ],
                                      ),
                                    ))
                                        .toList(),
                                    value: _bloodtypevalue,
                                    onChanged: (value) {
                                      setState(() {
                                        _bloodtypevalue = value!;
                                      });
                                    },
                                    icon:
                                    Icon(Icons.keyboard_arrow_down_sharp, size: 20),
                                    iconEnabledColor: Color(0xff023535),
                                    underline: Container(),
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff023535)),
                                    itemHeight: 48,
                                    dropdownColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "  Previous surgeries",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff667085)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomTextForm(
                                  errorvalidationtext: 'please enter your previous surgeries',
                                  hinttext: 'Enter your previous surgerious if any ', mycontroller: Previoussergeries,maxLines: 4,minLines: 4,),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "  Medication",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff667085)),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CustomTextForm(errorvalidationtext: 'please enter your medication',
                                  hinttext: 'Enter your medication if any', mycontroller: Medication,maxLines: 4,minLines: 4,),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "  Chronic Disease",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff667085)),
                                ),
                                Container(
                                  width: 500,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF2F4F7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Diabetes',
                                            style: TextStyle(
                                              color: Color(0xff667085),
                                            ),
                                          ),
                                          Checkbox(
                                              value: _isChecked1,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isChecked1 = value!;
                                                  print(_isChecked1);
                                                });
                                              },
                                              checkColor:
                                              MaterialStateColor.resolveWith(
                                                      (states) => Color(0xff667085))),
                                          SizedBox(width: 40),
                                          Text('        Heart disease',
                                              style: TextStyle(
                                                color: Color(0xff667085),
                                              )),
                                          Checkbox(
                                              value: _isChecked3,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isChecked3 = value!;
                                                  print(_isChecked3);
                                                });
                                              },
                                              checkColor:
                                              MaterialStateColor.resolveWith(
                                                      (states) => Color(0xff667085))),
                                        ],
                                      ),
                                      //  SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Text('Asthma',
                                              style: TextStyle(
                                                color: Color(0xff667085),
                                              )),
                                          Checkbox(
                                              value: _isChecked2,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isChecked2 = value!;
                                                  print(_isChecked2);
                                                });
                                              },
                                              checkColor:
                                              MaterialStateColor.resolveWith(
                                                      (states) => Color(0xff667085))),
                                          SizedBox(width: 20),
                                          Text('Inflammatory bowel',
                                              style: TextStyle(
                                                color: Color(0xff667085),
                                              )),
                                          Checkbox(
                                            value: _isChecked4,
                                            onChanged: (value) {
                                              setState(() {
                                                _isChecked4 = value!;
                                                print(_isChecked4);
                                              });
                                            },
                                            checkColor: MaterialStateColor.resolveWith(
                                                    (states) => Color(0xff667085)
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                CustomButtonAuth(
                                  title: 'Save',
                                  onPressed: () {
                                    insertPatient();
                                    Navigator.pushReplacementNamed(context, PatientHomeScreen.routeName);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              )
            ),
          ),
        ),
      ),
    );
  }

  String? Age = "Birth Date";
  var selectedDate = DateTime.now();
  void insertPatient(){
    Patient patient = Patient(
        email: viewModel.email,
        name: widget.name,
        age: viewModel.dateinput.text,
        medications: Medication.text,
        chronicdisease: viewModel.chronicdisease,
        previoussurgeries: Previoussergeries.text,
        phoneumber: phonenumber.text,
        doctororpatient: widget.doctororpatient,
        gender: _dropdownGendervalue ?? "",
        profileimagepath: viewModel.imageUrl,
        weight: weight.text,
        height: height.text,
        bloodtype: _bloodtypevalue ?? "");
    viewModel.insertPatient(patient);
  }


}
