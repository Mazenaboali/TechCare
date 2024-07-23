import 'package:tech_care/data/data%20base/My%20database.dart';
import 'package:tech_care/data/firebase/Patient_firestore_dataSource.dart';
import 'package:tech_care/data/repository/auth_reposatiory_impl.dart';
import 'package:tech_care/data/firebase/firebase_auth_datasource_impl.dart';
import 'package:tech_care/data/repository/patient_repository.dart';
import 'package:tech_care/domain/repository/auth_reposatiory_contract.dart';
import 'package:tech_care/domain/repository/patient-repository-contract.dart';
import 'package:tech_care/domain/use%20cases/Login_Use_case.dart';
import 'package:tech_care/domain/use%20cases/Patient%20use%20cases/insert_patient_use_case.dart';
import 'package:tech_care/domain/use%20cases/Register_use_case.dart';

AuthReposaitory getAuthReposaitory(
    FirebaseAuthDataSource firebaseAuthDataSource) {
  return AuthReposatioryImpl(firebaseAuthDataSource);
}

FirebaseAuthDataSource getFirebaseAuthDataSource() {
  return FirbaseAuthDataSourceImpl();
}

AuthReposaitory AuthRepoInjection() {
  return getAuthReposaitory(getFirebaseAuthDataSource());
}

LoginUseCase LoginUseCaseInjection() {
  return LoginUseCase(AuthRepoInjection());
}

RegisterUseCase RegisterUseCaseInjection() {
  return RegisterUseCase(AuthRepoInjection());
}

PatientRepository GePatientRepository(PatientDataSource patientDataSource) {
  return PatientRepositoryImpl(patientDataSource);
}

PatientFirestoreDataSource GetPatientDataSource(MyDatabase myDatabase) {
  return PatientFirestoreDataSource(myDatabase);
}

MyDatabase GetDataBase() {
  return MyDatabase();
}

PatientRepository PatientRepositoryInjection() {
  return GePatientRepository(GetPatientDataSource(GetDataBase()));
}

InsertPatientUseCase PatientUseCaseInjection() {
  return InsertPatientUseCase(PatientRepositoryInjection());
}
