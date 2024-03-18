import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tech_care/Base/Base_view_model.dart';
import 'package:tech_care/LoginScreen/Login_navigator.dart';

import '../Reposatiory/Impl/auth_reposatiory_impl.dart';
import '../Reposatiory/Impl/firebase_auth_datasource_impl.dart';
import '../Reposatiory/auth_reposatiory_contract.dart';
import '../utils/validation_utils.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  AuthReposaitory authReposaitory;

  LoginViewModel(this.authReposaitory);

  void SignIn(var formkey, TextEditingController email,
      TextEditingController password) async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    navigator?.ShowProgressDialog('Loading..');
    // dialogUtils.ShowProgressDialog(context, 'Loading..');
    try {
      String Newemail;
      ValidationUtils.isValidPhone(email.text) == true
          ? Newemail = "t" + email.text + "@techCare.com"
          : Newemail = email.text;
      await authReposaitory.SignIn(
          Newemail,
          password
              .text); //await FirebaseAuth.instance.signInWithEmailAndPassword(email: Newemail, password: password.text);
      navigator?.HideDialog();

      // dialogUtils.hideDialog(context);
      navigator?.gohome();
      // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      navigator?.HideDialog();
      // dialogUtils.hideDialog(context);
      if (e.code == 'invalid-credential') {
        navigator?.ShowMessage('your account or password is incorrect',
            posaction: 'ok');
        // dialogUtils.showMessage(
        //    context, 'your account or password is incorrect', posaction: 'ok',
        // );
      } else {
        navigator?.ShowMessage(e.code, posaction: 'ok');
        // dialogUtils.showMessage(context, e.code, posaction: 'ok',);
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
    var user = await authReposaitory
        .SignUpWithGoogle(); // await FirebaseAuth.instance.signInWithCredential(credential);
    if (user == null) {
      navigator?.ShowMessage('not exists');
    } else {
      var username = await user.displayName;

       navigator?.gohome();
      // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }
}
