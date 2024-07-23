import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/domain/Base_state.dart';
import 'package:tech_care/domain/dependency_injection.dart';
import 'package:tech_care/domain/register_navigator.dart';
import 'package:tech_care/presentation/Components/custom_form_field_password.dart';
import 'package:tech_care/presentation/LoginScreen/login_screen.dart';
import 'package:tech_care/presentation/Patient_or_doctor_screen.dart';
import 'package:tech_care/presentation/RegisterScreen/register_view_model.dart';
import '../Components/custom_button_auth.dart';
import '../Components/custom_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = 'RegisterScreen';
  var user=FirebaseAuth.instance.currentUser;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterViewModel>
    implements RegisterNavigator {
  @override
  RegisterViewModel initviewmodel() {
    // TODO: implement initviewmodel
    return RegisterViewModel(RegisterUseCaseInjection());
  }
  TextEditingController username = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool securedpassword = true;

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var selectedValue;
    return ChangeNotifierProvider(
      create: (_)=>viewmodel,
      child:
          Scaffold(

            appBar: AppBar(
              backgroundColor:Color(0xff057B7B) ,
              toolbarHeight:94,
              titleSpacing: 0,
              title: GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          height: 20,
                        ),
                        Text('Full Name',
                          style: TextStyle(
                            color: Color(0xff667085),
                            fontSize: 12
                        ),),
                        Container(
                          height: 10,
                        ),

                        CustomTextForm(
                          errorvalidationtext: 'Please enter your user name',
                          hinttext: "Enter your Full Name",
                          mycontroller: username,
                          suffixicon: Text('')
                        ),
                        Container(
                          height: 10,
                        ),
                        Text('Email or Phone Number',
                          style: TextStyle(
                              color: Color(0xff667085),
                              fontSize: 12
                          ),),
                        Container(
                          height: 10,
                        ),
                        CustomTextForm(
                          errorvalidationtext: 'Please enter your email or phone',
                          hinttext: "Enter Your ُEmail or phone",
                          mycontroller: email,
                          suffixicon: Icon(
                            Icons.email,
                            color: Color(0xff023535),
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Text('Password',
                          style: TextStyle(
                              color: Color(0xff667085),
                              fontSize: 12
                          ),),
                        Container(
                          height: 10,
                        ),
                        CustomTextFormPassword(
                          errorvalidationtext: 'Please enter your password',
                          hinttext: "ُPassword",
                          mycontroller: password,
                        ),
                        Container(
                          height: 10,
                        ),
                        Text('Confirm Password',
                          style: TextStyle(
                              color: Color(0xff667085),
                              fontSize: 12
                          ),),
                        Container(
                          height: 10,
                        ),

                        TextFormField(
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter your password';
                            }
                            else if (text.length < 6) {
                              return 'Password should at least 6 characters';
                            }
                           else if (text != password.text) {
                              return 'The passwords you entered do not match';
                            }

                            return null;
                          },
                          controller: confirmpassword,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffEAECF0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  securedpassword == true
                                      ? securedpassword = false
                                      : securedpassword = true;
                                  setState(() {});
                                },
                                child: securedpassword == true
                                    ? Icon(
                                  Icons.visibility_off,
                                  color: Color(0xff667085),
                                )
                                    : Icon(Icons.visibility, color: Color(0xff667085)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffEAECF0))
                              ),
                              filled: true,
                              fillColor: Color(0xffF2F4F7),
                              label: Text(
                                'Confirm Password',
                                style: TextStyle(
                                  color: Color(0xff667085),
                                ),
                              )),
                          obscureText: securedpassword,
                        ),
                        Container(height: 20),
                        CustomButtonAuth(
                            title: "Sign up",
                            onPressed: () {
                              SignUp();
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 90,
                              color: Color(0xffA1A8B0),
                              height: 2,
                            ),
                            Container(
                              width: 10,
                            ),
                            Text(
                              "or",
                              style: TextStyle(
                                color: Color(0xffA1A8B0),
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Container(
                              width: 90,
                              color: Color(0xffA1A8B0),
                              height: 2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: MaterialButton(
                            color: Colors.white,
                            onPressed: () {
                              signInWithGoogle();
                            },
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xffD0D5DD)),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            height: 52,
                            minWidth: 328,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/google_icon.png',
                                  width: 15,
                                  height: 15,
                                ),
                                SizedBox(width: 12.0),
                                Text(
                                  'Sign up with Google',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff023535),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('By clicking register you agree to our Terms and Conditions of Use',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                color: Color(0xff344054)
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account ? ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xff221F1F),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              },
                              child: Text(
                                ' Sign in',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff407CE2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),

    );
  }

  void SignUp() async {
   viewmodel.SignUp(formkey, email, password);
  }

  Future signInWithGoogle() async {
    viewmodel.signInWithGoogle();
  }

  @override
  void PatietDoctorScreen() {
    // TODO: implement PatietDoctorScreen
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PatientOrDoctorScreen(username.text)))
    ;

  }

  @override
  void PatientDoctorScreenGmail(String displayName) {
    // TODO: implement PatientDoctorScreenGmail
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PatientOrDoctorScreen("")));


  }


}
