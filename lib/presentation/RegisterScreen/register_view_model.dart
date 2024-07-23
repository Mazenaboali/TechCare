import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_care/domain/use%20cases/Register_use_case.dart';
import 'package:tech_care/presentation/Base_view_model.dart';
import 'package:tech_care/domain/repository/auth_reposatiory_contract.dart';
import 'package:tech_care/domain/register_navigator.dart';
import 'package:tech_care/domain/utils/validation_utils.dart';


class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  RegisterUseCase registerUseCase;

  RegisterViewModel(this.registerUseCase);

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
      registerUseCase.Invoke(Newemail, password.text);

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
    var user = await registerUseCase.InvokeWithGoogle();
    if (user == null) {
      navigator?.ShowMessage('not exists');
    } else {
      var username = await user.displayName;
      navigator?.PatientDoctorScreenGmail(username??"_");
    }
  }
}
