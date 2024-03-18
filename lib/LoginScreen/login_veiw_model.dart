import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_care/Base/Base_view_model.dart';
import 'package:tech_care/LoginScreen/Login_navigator.dart';

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
    try {
      String Newemail;
      ValidationUtils.isValidPhone(email.text) == true
          ? Newemail = "t" + email.text + "@techCare.com"
          : Newemail = email.text;
      await authReposaitory.SignIn(Newemail, password.text);
      navigator?.HideDialog();

      navigator?.gohome();
    } on FirebaseAuthException catch (e) {
      navigator?.HideDialog();
      if (e.code == 'invalid-credential') {
        navigator?.ShowMessage('your account or password is incorrect',
            posaction: 'ok');
      } else {
        navigator?.ShowMessage(e.code, posaction: 'ok');
      }
    }
  }

  Future signInWithGoogle() async {
    var user = await authReposaitory.SignUpWithGoogle();
    if (user == null) {
      navigator?.ShowMessage('not exists');
    } else {
      var username = await user.displayName;
      navigator?.gohome();
    }
  }
}
