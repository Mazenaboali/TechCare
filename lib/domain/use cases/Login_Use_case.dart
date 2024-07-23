import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_care/domain/repository/auth_reposatiory_contract.dart';

class LoginUseCase{
  AuthReposaitory authReposaitory;

  LoginUseCase(this.authReposaitory);
  void Invoke(String Newemail,String password) async{
    await authReposaitory.SignIn(Newemail, password);
  }
  Future<User?>? InvokeWithGoogle() async{
   return  authReposaitory.SignUpWithGoogle();
  }
  String? getEmail(){
    return authReposaitory.getCurrentUserEmail();
  }
}