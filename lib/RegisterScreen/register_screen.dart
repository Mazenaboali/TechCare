import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/Base/Base_state.dart';
import 'package:tech_care/Components/custom_form_field_password.dart';
import 'package:tech_care/HomeScreen/patient_home_screen.dart';
import 'package:tech_care/LoginScreen/login_screen.dart';
import 'package:tech_care/Patient_or_doctor_screen.dart';
import 'package:tech_care/RegisterScreen/register_navigator.dart';
import 'package:tech_care/RegisterScreen/register_view_model.dart';
import 'package:tech_care/dependency_injection.dart';
import 'package:tech_care/utils/dialog_utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tech_care/utils/validation_utils.dart';
import '../Components/custom_button_auth.dart';
import '../Components/custom_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterViewModel>
    implements RegisterNavigator {
  @override
  RegisterViewModel initviewmodel() {
    // TODO: implement initviewmodel
    return RegisterViewModel(AuthRepoInjection());
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
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/images/techCare_background.png',
                fit: BoxFit.fill),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 210,
                            ),
                            Text("Sign up",
                                style: TextStyle(
                                    fontFamily: 'Capriola',
                                    fontSize: 36,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          ],
                        ),
                        Container(
                          height: 30,
                        ),
                        CustomTextForm(
                          errorvalidationtext: 'Please enter your user name',
                          hinttext: " Full name",
                          mycontroller: username,
                          suffixicon: Text('')
                        ),
                        Container(height: 15),
                        CustomTextForm(
                          errorvalidationtext: 'Please enter your email or phone',
                          hinttext: "ُEmail or phone",
                          mycontroller: email,
                          suffixicon: Icon(
                            Icons.email,
                            color: Color(0xff023535),
                          ),
                        ),
                        Container(height: 15),
                        CustomTextFormPassword(
                          errorvalidationtext: 'Please enter your password',
                          hinttext: "ُPassword",
                          mycontroller: password,
                        ),
                        Container(height: 15),
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
                                        color: Color(0xff023535),
                                      )
                                    : Icon(Icons.visibility,
                                        color: Color(0xff023535)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xff023535)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: Text(
                                'Confirm password',
                                style: TextStyle(
                                  color: Color(0xff023535),
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
                              width: 70,
                              color: Color(0xff023535),
                              height: 2,
                            ),
                            Container(
                              width: 10,
                            ),
                            Text(
                              "or",
                              style: TextStyle(
                                color: Color(0xff023535),
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Container(
                              width: 70,
                              color: Color(0xff023535),
                              height: 2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          color: Colors.white,
                          onPressed: () {
                          signInWithGoogle();
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xff023535)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 60,
                          minWidth: 320,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/google_icon.png',
                                width: 40,
                                height: 32,
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
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have account ?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff023535),
                              ),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, LoginScreen.routeName);
                                  },
                                  child: Text(
                                    ' Sign in',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff0FC2C0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  color: Color(0xff0FC2C0),
                                  height: 2,
                                )
                              ],
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
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
    Navigator.pushReplacementNamed(context, PatientOrDoctorScreen.routeName);

  }


}
