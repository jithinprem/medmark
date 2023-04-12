import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medmark/patient_data.dart';



class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  add_my_patient(AddPatientData addDataPat){
    print('add_my_patient is being called');
    final CollectionReference patients_collection_ref = FirebaseFirestore.instance.collection('patient');
    final String patient_id = addDataPat.patient_id;
    final DocumentReference patientDocRef = patients_collection_ref.doc(patient_id);
    final CollectionReference dateCollectionRef = patientDocRef.collection('date');
    DateTime now = DateTime.now();
    String formattedDate = '${now.day}-${now.month}-${now.year}';
    formattedDate = '10-4-2023';
    final Map<String, dynamic> marksData = {
        'pain' : addDataPat.painval,
        'tiredness' : addDataPat.tiredness,
        'drowsiness' : addDataPat.drowsiness,
        'nausea' : addDataPat.nausea,
        'lack_appetite' : addDataPat.lack_aptitite,
        'shortness_breath' : addDataPat.shortness_breath,
        'depression' : addDataPat.depression,
        'anxiety' : addDataPat.anxiety,
        'best_wellbeing' : addDataPat.wellbeing,
        'additional_comments' : addDataPat.additional_comment,
    };
    dateCollectionRef.doc(formattedDate).set(marksData);

  }

  addUserVal(AddPatientData addDataPat){
    print('ADD DATA BEIGN EXECUTED');
    _db.collection("Patients").add(addDataPat.toJson()).whenComplete(() =>
      Get.snackbar("Success", "data entered to firestore",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.lightGreen.withOpacity(0.1),
        colorText: Colors.black,
      ),
    ).catchError((error, stackTrace){
      print('ERROR FOUND BY JP');
      print(error.toString());
      return Get.snackbar("Failed", "data NOT entered to firestore",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.black,
      );

    });
  }


}