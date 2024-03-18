import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_care/Reposatiory/auth_reposatiory_contract.dart';

class AuthReposatioryImpl implements AuthReposaitory {
  FirebaseAuthDataSource firebaseAuthDataSource;

  AuthReposatioryImpl(this.firebaseAuthDataSource);

  @override
  Future<void> SignIn(String email, String password) async{
    // TODO: implement SignIn
   await firebaseAuthDataSource.SignIn(email, password);
  }

  @override
  Future<void> SignUp(String email, String password) async{
    // TODO: implement SignUp
    await firebaseAuthDataSource.SignUp(email, password);
  }

  @override
  Future<User?> SignUpWithGoogle() async{
    // TODO: implement SignUpWithGoogle
   var userCredential= await firebaseAuthDataSource.SignUpWithGoogle();
   return userCredential.user;
  }
}
