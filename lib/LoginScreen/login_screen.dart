import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/Base/Base_state.dart';
import 'package:tech_care/Components/custom_form_field_password.dart';
import 'package:tech_care/HomeScreen/doctor_home_screen.dart';
import 'package:tech_care/HomeScreen/patient_home_screen.dart';
import 'package:tech_care/LoginScreen/Login_navigator.dart';
import 'package:tech_care/LoginScreen/login_veiw_model.dart';
import 'package:tech_care/RegisterScreen/register_screen.dart';
import 'package:tech_care/dependency_injection.dart';
import 'package:tech_care/utils/dialog_utils.dart';
import '../Components/custom_button_auth.dart';
import '../Components/custom_form_field.dart';
import '../utils/validation_utils.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  @override
  LoginViewModel initviewmodel() {
    // TODO: implement initviewmodel
    return LoginViewModel(AuthRepoInjection());
  }
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (_)=>viewmodel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Color(0xff057B7B) ,
          toolbarHeight: 94,
          titleSpacing: 0,
          title: GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
              'Welcome Back',
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Container(height: 100),
                        Text('Email or Phone number',style: TextStyle(
                          color: Color(0xff667085),
                          fontSize: 12
                        ),),
                        Container(height: 10),
                        CustomTextForm(
                          errorvalidationtext: 'Please enter your email',
                          hinttext: "ُEmail or phone",
                          mycontroller: email,
                          suffixicon: Icon(
                            Icons.email,
                            color: Color(0xff667085),
                          ),
                        ),
                        Container(height: 20),
                        Text('Password',style: TextStyle(
                            color: Color(0xff667085),
                            fontSize: 12
                        ),),
                        Container(height: 10),
                        CustomTextFormPassword(
                          errorvalidationtext: 'Please enter your password',
                          hinttext: "Password",
                          mycontroller: password,
                        ),
                        Container(height: 30),
                        CustomButtonAuth(
                            title: "Sign in",
                            onPressed: () {
                              SignIn();
                            }),
                        SizedBox(
                          height: 20,
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
                          height: 20,
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
                                  'Sign in with Google',
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
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don`t have an account ? ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xff221F1F),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, RegisterScreen.routeName);
                              },
                              child: Text(
                                ' Sign up',
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

  void SignIn() async {
   viewmodel.SignIn(formkey, email, password);
  }

  Future signInWithGoogle() async {
   viewmodel.signInWithGoogle();
  }

  @override
  void DoctorHome() {
   Navigator.pushReplacementNamed(context, DoctorHomeScreen.routeName);
  }

  @override
  void PatientHome() {
    Navigator.pushReplacementNamed(context, PatientHomeScreen.routeName);
  }




}
