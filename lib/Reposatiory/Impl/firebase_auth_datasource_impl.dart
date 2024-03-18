import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tech_care/Reposatiory/auth_reposatiory_contract.dart';

class FirbaseAuthDataSourceImpl implements FirebaseAuthDataSource{
  @override
  Future<void> SignIn(String email, String password) async{
    // TODO: implement SignIn
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> SignUp( String email, String password,) async{
    // TODO: implement SignUp
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

  }

  @override
  Future<UserCredential> SignUpWithGoogle() async{
    // TODO: implement SignUpWithGoogle
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var usercredential= await FirebaseAuth.instance.signInWithCredential(credential);
    return usercredential;
  }

}