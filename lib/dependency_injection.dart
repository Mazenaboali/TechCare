import 'package:tech_care/Reposatiory/Impl/auth_reposatiory_impl.dart';
import 'package:tech_care/Reposatiory/Impl/firebase_auth_datasource_impl.dart';
import 'package:tech_care/Reposatiory/auth_reposatiory_contract.dart';

AuthReposaitory getAuthReposaitory(FirebaseAuthDataSource firebaseAuthDataSource)
{
  return AuthReposatioryImpl(firebaseAuthDataSource);
}
FirebaseAuthDataSource getFirebaseAuthDataSource()
{
  return FirbaseAuthDataSourceImpl();
}
AuthReposaitory AuthRepoInjection(){
  return getAuthReposaitory(getFirebaseAuthDataSource());
}
