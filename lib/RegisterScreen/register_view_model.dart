import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_care/Base/Base_view_model.dart';
import 'package:tech_care/RegisterScreen/register_navigator.dart';
import 'package:tech_care/Reposatiory/auth_reposatiory_contract.dart';

import '../utils/validation_utils.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  AuthReposaitory authReposaitory;

  RegisterViewModel(this.authReposaitory);

  void SignUp(var formkey, TextEditingController email,
      TextEditingController password) async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    navigator?.ShowProgressDialog('Loading...');
    String? Newemail;
    try {
      ValidationUtils.isValidPhone(email.text) == true
          ? Newemail = "t" + email.text + "@techCare.com"
          : Newemail = email.text;
      await authReposaitory.SignUp(Newemail, password.text);

      navigator?.HideDialog();
      navigator?.PatietDoctorScreen();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        navigator?.HideDialog();
        navigator?.ShowMessage('The account already exists for that Email',
            posaction: 'OK');
      } else {
        navigator?.ShowMessage(
          e.code,
          posaction: 'ok',
        );
      }
    }
  }

  Future signInWithGoogle() async {
    // Once signed in, return the UserCredential
    var user = await authReposaitory.SignUpWithGoogle();
    if (user == null) {
      navigator?.ShowMessage('not exists');
    } else {
      var username = await user.displayName;

      navigator?.PatietDoctorScreen();
    }
  }
}
