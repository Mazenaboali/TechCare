


class Examination {
  String? patientimagepath;
  String? doctorimagepath;
  String patientemail;
  String doctoremail;
  String doctorname;
  String doctoradress;
  String date;
  String patientname;
  String report;
  String? prescriptiontext;
  String? prescriptionimagepath;
  List<String>? analysisimagepath;

  Examination(
      {required this.doctorname,
      required this.doctoradress,
      required this.date,
      required this.patientname,
      required this.report,
        this.doctorimagepath,
        this.patientimagepath,
       this.prescriptiontext,
       this.prescriptionimagepath,
       this.analysisimagepath,
      required this.doctoremail,
      required this.patientemail});
  Examination.FromFirestore(Map<String, dynamic> data)
      : this(
    doctorimagepath: data['doctorimagepath'],
    patientimagepath: data['patientimagepath'],
    doctorname: data['doctorname'],
    doctoradress: data['doctoradress'],
    date: data['date'],
    patientname: data['patientname'],
    report: data['report'],
    prescriptiontext: data['prescriptiontext'],
    prescriptionimagepath: data['prescriptionimagepath'],
    analysisimagepath: data['analysisimagepath'],
    doctoremail: data['doctoremail'],
    patientemail: data['patientemail'],

  );
  Map<String, dynamic> ToFirestore() {
    return {
      'patientimagepath':patientimagepath,
      'doctorimagepath':doctorimagepath,
      'doctorname': doctorname,
      'doctoradress': doctoradress,
      'date': date,
      'patientname':patientname,
      'report': report,
      'prescriptiontext': prescriptiontext,
      'prescriptionimagepath': prescriptionimagepath,
      'analysisimagepath': analysisimagepath,
      'doctoremail': doctoremail,
      'patientemail': patientemail,

    };
  }


}
