

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_care/database/DoctorDTO.dart';
import 'package:tech_care/database/PatientDTO.dart';
import 'package:tech_care/database/examinationDTO.dart';
import 'package:tech_care/database/messageDTO.dart';

class MyDatabase {
   void insertPatient(String document, PatientDTO patient) async {
    var db = FirebaseFirestore.instance;
    var ref = db
        .collection('patient')
        .withConverter<PatientDTO>(
            fromFirestore: (snapshot, options) =>
                PatientDTO.FromFirestore(snapshot.data()!),
            toFirestore: (patient, options) => patient.ToFirestore())
        .doc(document);
    await ref.set(patient);
  }

  static void insertDoctor(String document, DoctorDTO doctor) async {
    var db = FirebaseFirestore.instance;
    var ref = db
        .collection('doctor')
        .withConverter<DoctorDTO>(
            fromFirestore: (snapshot, options) =>
                DoctorDTO.FromFirestore(snapshot.data()!),
            toFirestore: (doctor, options) => doctor.ToFirestore())
        .doc(document);
    await ref.set(doctor);
  }

  static Future<PatientDTO?> getPatientData(String document) async {
    var db = FirebaseFirestore.instance;
    final ref = db.collection("patient").doc(document).withConverter<PatientDTO>(
        fromFirestore: (snapshot, options) =>
            PatientDTO.FromFirestore(snapshot.data()!),
        toFirestore: (patient, options) => patient.ToFirestore());

    final docSnap = await ref.get();
    final patient = docSnap.data();
    return patient;
  }
  static Stream<QuerySnapshot<MessageDTO>> getMessages()  {
   var ref=   FirebaseFirestore.instance
        .collection('messages')
        .orderBy('timestamp', descending: true).withConverter<MessageDTO>(
       fromFirestore: (snapshot, options) =>
           MessageDTO.FromFirestore(snapshot.data()!),
       toFirestore: (message, options) => message.ToFirestore());

   final querySnapShot =  ref.snapshots();

    return querySnapShot;
  }

  static Future<DoctorDTO?> getDoctorData(String document) async {
    var db = FirebaseFirestore.instance;
    final ref = db.collection("doctor").doc(document).withConverter<DoctorDTO>(
        fromFirestore: (snapshot, options) =>
            DoctorDTO.FromFirestore(snapshot.data()!),
        toFirestore: (doctor, options) => doctor.ToFirestore());

    final docSnap = await ref.get();
    final doctor = docSnap.data();
    return doctor;
  }


  static void insertPatientExamination(String collection,String document, ExaminationDTO examination)async{

    var db = FirebaseFirestore.instance;
    var ref = db
        .collection(collection)
        .withConverter<PatientDTO>(
        fromFirestore: (snapshot, options) =>
            PatientDTO.FromFirestore(snapshot.data()!),
        toFirestore: (patient, options) => patient.ToFirestore())
        .doc(document).collection('Examinations').withConverter<ExaminationDTO>(
        fromFirestore: (snapshot, options) =>
            ExaminationDTO.FromFirestore(snapshot.data()!),
        toFirestore: (examination, options) => examination.ToFirestore());
      examination.id=ref.doc().id;
      await ref.add(examination);

  }

  static Future<List<ExaminationDTO>> getExaminations(String collection,String document)async{
    var db = FirebaseFirestore.instance;
    var ref = db
        .collection(collection)
        .withConverter<PatientDTO>(
        fromFirestore: (snapshot, options) =>
            PatientDTO.FromFirestore(snapshot.data()!),
        toFirestore: (patient, options) => patient.ToFirestore())
        .doc(document).collection('Examinations').withConverter<ExaminationDTO>(
        fromFirestore: (snapshot, options) =>
            ExaminationDTO.FromFirestore(snapshot.data()!),
        toFirestore: (examination, options) => examination.ToFirestore());
    var querySnapShot= await ref.get();
    var examinationList = querySnapShot.docs.map((doc) => doc.data()).toList();
    return examinationList;

  }

  static void insertMessage(MessageDTO message)async{

    var db = FirebaseFirestore.instance;
    var ref = db
        .collection('messages')
        .withConverter<MessageDTO>(
        fromFirestore: (snapshot, options) =>
            MessageDTO.FromFirestore(snapshot.data()!),
        toFirestore: (message, options) => message.ToFirestore())
        .doc();
    await ref.set(message);
  }
}
