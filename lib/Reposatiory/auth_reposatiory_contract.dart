import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthReposaitory {
  Future<void> SignIn(String email, String password);
  Future<void> SignUp(String email, String password);
  Future<User?> SignUpWithGoogle();
}

abstract class FirebaseAuthDataSource {
  Future<void> SignIn(String email, String password);
  Future<void> SignUp(
    String email,
    String password,
  );
  Future<UserCredential> SignUpWithGoogle();
}
