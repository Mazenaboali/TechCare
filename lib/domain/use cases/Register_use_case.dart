import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_care/domain/repository/auth_reposatiory_contract.dart';

class RegisterUseCase{
  AuthReposaitory authReposaitory;

  RegisterUseCase(this.authReposaitory);
  void Invoke(String Newemail,String password) async{
    await authReposaitory.SignUp(Newemail, password);
  }
  Future<User?>? InvokeWithGoogle() async{
    return  authReposaitory.SignUpWithGoogle();
  }
}