import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_care/data/data%20base/My%20database.dart';
import 'package:tech_care/data/model/PatientDTO.dart';
import 'package:tech_care/domain/model/Patient.dart';
import 'package:tech_care/domain/use%20cases/Login_Use_case.dart';
import 'package:tech_care/domain/use%20cases/Patient%20use%20cases/insert_patient_use_case.dart';

class PatientFormViewModel extends ChangeNotifier {
  InsertPatientUseCase insertPatientUseCase;
  LoginUseCase loginUseCase;

  TextEditingController dateinput = TextEditingController();
  String chronicdisease = "";

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;
  late String? email=loginUseCase.getEmail();
  var image;
  String? imageUrl;

  var selectedDate = DateTime.now();
  PatientFormViewModel(
      {
        required this.loginUseCase,
        required this.insertPatientUseCase,
     });

  void ShowDatepark(BuildContext context) async {
    var userSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.fromMillisecondsSinceEpoch(-1446429609000),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (userSelectedDate == null) {
      return;
    } else {
      selectedDate = userSelectedDate;

      if (DateTime.now().month < selectedDate.month &&
          DateTime.now().day < selectedDate.day) {
        var age = (DateTime.now().year - selectedDate.year) - 1;
        dateinput.text= age.toString();
      } else {
        var age = (DateTime.now().year - selectedDate.year);
        dateinput.text = age.toString();
      }

    }
  }

  Future<void> insertPatient(Patient patient) async{
    if (formkey.currentState?.validate() == false) {
      return;
    }
    if (_isChecked1) {
      chronicdisease += "diabse , ";
    }
    if (_isChecked2) {
      chronicdisease += "Asthma , ";
    }
    if (_isChecked3) {
      chronicdisease += "Heart disease , ";
    }
    if (_isChecked4) {
      chronicdisease += "inflammatory bowel , ";
    }
     await insertPatientUseCase.Invoke(email!, patient);
  }

  void uploadImage(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);


      try {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final firebaseStorageRef =
            FirebaseStorage.instance.ref().child(fileName);
        final uploadTask = firebaseStorageRef.putFile(image);

        final snapshot = await uploadTask.whenComplete(() {});

        if (snapshot.state == TaskState.success) {
          final downloadURL = await snapshot.ref.getDownloadURL();
          imageUrl = downloadURL;

        } else {
          imageUrl = null;

        }

      } catch (ex) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('uploading image failed')));
      }
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('no images selected')));
    }
  }
}
