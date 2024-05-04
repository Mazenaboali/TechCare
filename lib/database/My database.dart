import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_care/database/Patient.dart';

class MyDatabase {
 static void insertPatient(String document, Patient patient) async {
    var db = FirebaseFirestore.instance;
    var ref = db
        .collection('patient')
        .withConverter<Patient>(
            fromFirestore: (snapshot, options) =>
                Patient.FromFirestore(snapshot.data()!),
            toFirestore: (patient, options) => patient.ToFirestore())
        .doc(document);
    await ref.set(patient);
  }

 static Future<Patient?> getPatientData(String document) async {
    var db = FirebaseFirestore.instance;
    final ref = db.collection("patient").doc(document).withConverter<Patient>(
        fromFirestore: (snapshot, options) =>
            Patient.FromFirestore(snapshot.data()!),
        toFirestore: (patient, options) => patient.ToFirestore());

    final docSnap = await ref.get();
    final patient = docSnap.data();
    return patient;
  }
}
