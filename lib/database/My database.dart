

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_care/database/Doctor.dart';
import 'package:tech_care/database/Patient.dart';
import 'package:tech_care/database/examination.dart';
import 'package:tech_care/database/messages.dart';

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

  static void insertDoctor(String document, Doctor doctor) async {
    var db = FirebaseFirestore.instance;
    var ref = db
        .collection('doctor')
        .withConverter<Doctor>(
            fromFirestore: (snapshot, options) =>
                Doctor.FromFirestore(snapshot.data()!),
            toFirestore: (doctor, options) => doctor.ToFirestore())
        .doc(document);
    await ref.set(doctor);
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
  static Stream<QuerySnapshot<Message>> getMessages()  {
   var ref=   FirebaseFirestore.instance
        .collection('messages')
        .orderBy('timestamp', descending: true).withConverter<Message>(
       fromFirestore: (snapshot, options) =>
           Message.FromFirestore(snapshot.data()!),
       toFirestore: (message, options) => message.ToFirestore());

   final querySnapShot =  ref.snapshots();

    return querySnapShot;
  }

  static Future<Doctor?> getDoctorData(String document) async {
    var db = FirebaseFirestore.instance;
    final ref = db.collection("doctor").doc(document).withConverter<Doctor>(
        fromFirestore: (snapshot, options) =>
            Doctor.FromFirestore(snapshot.data()!),
        toFirestore: (doctor, options) => doctor.ToFirestore());

    final docSnap = await ref.get();
    final doctor = docSnap.data();
    return doctor;
  }


  static void insertPatientExamination(String collection,String document, Examination examination)async{

    var db = FirebaseFirestore.instance;
    var ref = db
        .collection(collection)
        .withConverter<Patient>(
        fromFirestore: (snapshot, options) =>
            Patient.FromFirestore(snapshot.data()!),
        toFirestore: (patient, options) => patient.ToFirestore())
        .doc(document).collection('Examinations').withConverter<Examination>(
        fromFirestore: (snapshot, options) =>
            Examination.FromFirestore(snapshot.data()!),
        toFirestore: (examination, options) => examination.ToFirestore());
      examination.id=ref.doc().id;
      await ref.add(examination);

  }

  static Future<List<Examination>> getExaminations(String collection,String document)async{
    var db = FirebaseFirestore.instance;
    var ref = db
        .collection(collection)
        .withConverter<Patient>(
        fromFirestore: (snapshot, options) =>
            Patient.FromFirestore(snapshot.data()!),
        toFirestore: (patient, options) => patient.ToFirestore())
        .doc(document).collection('Examinations').withConverter<Examination>(
        fromFirestore: (snapshot, options) =>
            Examination.FromFirestore(snapshot.data()!),
        toFirestore: (examination, options) => examination.ToFirestore());
    var querySnapShot= await ref.get();
    var examinationList = querySnapShot.docs.map((doc) => doc.data()).toList();
    return examinationList;

  }

  static void insertMessage(Message message)async{

    var db = FirebaseFirestore.instance;
    var ref = db
        .collection('messages')
        .withConverter<Message>(
        fromFirestore: (snapshot, options) =>
            Message.FromFirestore(snapshot.data()!),
        toFirestore: (message, options) => message.ToFirestore())
        .doc();
    await ref.set(message);
  }
}
