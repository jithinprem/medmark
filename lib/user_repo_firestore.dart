import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medmark/patient_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  @override
  void initState(){
    getEndpoint();
  }

  // variables
  String endpoint = 'None';   // used to save endpoint

  final _db = FirebaseFirestore.instance;

  // this function is used to add user to firebase firestore
  add_my_patient(AddPatientData addDataPat, context){
    print('add_my_patient is being called');
    final CollectionReference patients_collection_ref = FirebaseFirestore.instance.collection('patient');
    final String patient_id = addDataPat.patient_id;
    final DocumentReference patientDocRef = patients_collection_ref.doc(patient_id);
    final CollectionReference dateCollectionRef = patientDocRef.collection('date');
    DateTime now = DateTime.now();
    String formattedDate = '${now.day}-${now.month}-${now.year}';
    //formattedDate = formattedDate + '';
    //formattedDate = '12-4-2023';
    final Map<String, dynamic> marksData = {
        'name' : addDataPat.fullname,
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
    dateCollectionRef.doc(formattedDate).set(marksData).then((value) {
      print('patient data added successfully!');
      // add to exel from here
      addToExel(addDataPat, context);

    }).catchError((error) {
      print('Failed to add patient data: $error');

    });

  }

  // just a sample function to test
  /*addUserVal(AddPatientData addDataPat){
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
  */

  // get the endpoint
  getEndpoint() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myString = prefs.getString('endpoint') ?? 'None';
    this.endpoint = myString;
    return myString;
  }

  // function to add to excel
  addToExel(AddPatientData addDataPat, BuildContext context) async{

    // getting date
    DateTime now = DateTime.now();
    String formattedDate = '${now.day}-${now.month}-${now.year}';

    // getting saved endpoint
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.endpoint = prefs.getString('endpoint') ?? 'None';
    print('adding data to excel with endpoint : ');
    print(this.endpoint);

    //[user.id, user.name, user.date, user.pain, user.tiredness, user.drowsiness, user.nausea,
    //  user.lack_appetite, user.short_breath, user.depression, user.anxiety, user.well_being, user.additional_cmt ]

    final Map<String, dynamic> marksData = {
      'id' : addDataPat.patient_id,
      'name' : addDataPat.fullname,
      'date' : formattedDate,
      'pain' : addDataPat.painval,
      'tiredness' : addDataPat.tiredness,
      'drowsiness' : addDataPat.drowsiness,
      'nausea' : addDataPat.nausea,
      'lack_appetite' : addDataPat.lack_aptitite,
      'short_breath' : addDataPat.shortness_breath,
      'depression' : addDataPat.depression,
      'anxiety' : addDataPat.anxiety,
      'well_being' : addDataPat.wellbeing,
      'additional_cmt' : addDataPat.additional_comment,
    };


    final response = await http.post(
      Uri.parse(this.endpoint + '?' + 'action=addUser'),
      body: jsonEncode(marksData),
    );
    if (response.statusCode == 200 || response.statusCode == 302) {
      // Show success alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            backgroundColor: Colors.white,
            icon: Icon(Icons.verified, color: Colors.green,size: 40,),
            title: Text('Success :)', style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 24)),),
            content: Text('data updated successfully.', style: GoogleFonts.roboto(),),
            actions: [
              TextButton(
                child: Text('OK', style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.black87)),),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  },
              ),
            ],
          );
        },
      );
    } else {
      print('error code is : ');
      print(response.statusCode);
      // Handle API errors here
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            backgroundColor: Colors.white,
            icon: Icon(Icons.error, color: Colors.redAccent,size: 40,),
            title: Text('Failed', style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 24)),),
            content: Text('error updating on excel', style: GoogleFonts.roboto(),),
            actions: [
              TextButton(
                child: Text('OK', style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.black87)),),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }

  }


}