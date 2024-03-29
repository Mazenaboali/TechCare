import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tech_care/Base/Base_state.dart';
import 'package:tech_care/Components/custom_form_field_password.dart';
import 'package:tech_care/HomeScreen/home_screen.dart';
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
                        Container(height: 199),
                        const Text("Login",
                            style: TextStyle(
                                fontFamily: 'Capriola',
                                fontSize: 36,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff023535))),
                        Container(height: 30),
                        CustomTextForm(
                          errorvalidationtext: 'Please enter your email',
                          hinttext: "ُEmail or phone",
                          mycontroller: email,
                          suffixicon: Icon(
                            Icons.email,
                            color: Color(0xff023535),
                          ),
                        ),
                        Container(height: 30),
                        CustomTextFormPassword(
                          errorvalidationtext: 'Please enter your password',
                          hinttext: "Password",
                          mycontroller: password,
                        ),
                        Container(height: 30),
                        CustomButtonAuth(
                            title: "login",
                            onPressed: () {
                              SignIn();
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
                                'Sign in with Google',
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
                              'Don`t have an account ? ',
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
                                        context, RegisterScreen.routeName);
                                  },
                                  child: Text(
                                    ' Sign up',
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

  void SignIn() async {
   viewmodel.SignIn(formkey, email, password);
  }

  Future signInWithGoogle() async {
   viewmodel.signInWithGoogle();
  }

  @override
  void gohome() {
    // TODO: implement gohome
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }


}
