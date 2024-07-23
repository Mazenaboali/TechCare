import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_care/domain/use%20cases/Login_Use_case.dart';
import 'package:tech_care/presentation/Base_view_model.dart';
import 'package:tech_care/domain/repository/auth_reposatiory_contract.dart';
import 'package:tech_care/domain/Login_navigator.dart';
import 'package:tech_care/data/data%20base/My%20database.dart';
import 'package:tech_care/database/PatientDTO.dart';
import 'package:tech_care/domain/utils/validation_utils.dart';


class LoginViewModel extends BaseViewModel<LoginNavigator> {
  LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase);

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
      loginUseCase.Invoke(Newemail, password.text);
      print(Newemail);
      var data =  await MyDatabase.getPatientData(Newemail);
      print(data?.doctororpatient);
      if(data==null)
        {
        }
      if(data==null){
        navigator?.HideDialog();
        navigator?.DoctorHome();
      }
      else {
        navigator?.HideDialog();
        navigator?.PatientHome();
      }



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
    var user = await loginUseCase.InvokeWithGoogle();
    if (user == null) {
      navigator?.ShowMessage('not exists');
    } else {
      PatientDTO? data =  await MyDatabase.getPatientData(user.email??" ");
      if(data?.doctororpatient=='patient'){
        navigator?.PatientHome();
      }
      else if(data?.doctororpatient==null){
        navigator?.DoctorHome();
      }

    }
  }
}
