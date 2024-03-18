import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tech_care/Base/Base_view_model.dart';
import 'package:tech_care/RegisterScreen/register_navigator.dart';
import 'package:tech_care/Reposatiory/Impl/auth_reposatiory_impl.dart';
import 'package:tech_care/Reposatiory/auth_reposatiory_contract.dart';

import '../Reposatiory/Impl/firebase_auth_datasource_impl.dart';
import '../utils/validation_utils.dart';
class RegisterViewModel   extends BaseViewModel<RegisterNavigator>{
  AuthReposaitory authReposaitory;

  RegisterViewModel(this.authReposaitory);

  void SignUp(var formkey,TextEditingController email,TextEditingController password) async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    navigator?.ShowProgressDialog('Loading...');
    // dialogUtils.ShowProgressDialog(context, 'Loading...');
    print('*****************Registerrrrrrrrrrrrrr*********');
    String? Newemail;
    try {
      ValidationUtils.isValidPhone(email.text) == true
          ? Newemail = "t" + email.text + "@techCare.com"
          : Newemail = email.text;
     await authReposaitory.SignUp(Newemail, password.text);
      // await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: Newemail,
      //   password: password.text,
      // );
      navigator?.HideDialog();
     // dialogUtils.hideDialog(context);
      navigator?.PatietDoctorScreen();
     // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        navigator?.HideDialog();
       // dialogUtils.hideDialog(context);
        navigator?.ShowMessage('The account already exists for that Email',posaction: 'OK');
       //  dialogUtils.showMessage(
       //      context, 'The account already exists for that Email',
       //      posaction: 'ok');
      } else {
        print(ValidationUtils.isValidPhone(email.text));
        print(Newemail ?? "222");
        navigator?.ShowMessage(e.code,posaction: 'ok',);
        // dialogUtils.showMessage(
        //   context,
        //   e.code,
        //   posaction: 'ok',
        // );
      }
    }
  }

  Future signInWithGoogle() async {
    // // Trigger the authentication flow
    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //
    // // Obtain the auth details from the request
    // final GoogleSignInAuthentication? googleAuth =
    // await googleUser?.authentication;

    // Create a new credential
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );

    // Once signed in, return the UserCredential
    var user = await authReposaitory.SignUpWithGoogle(); // await FirebaseAuth.instance.signInWithCredential(credential);
    if (user == null) {
     navigator?.ShowMessage('not exists');
    } else {
     var username= await user.displayName;

      navigator?.PatietDoctorScreen();
      // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }
}