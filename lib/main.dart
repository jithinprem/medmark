import 'package:flutter/material.dart';
import 'package:medmark/addnewpatient.dart';
import 'package:medmark/analyze.dart';
import 'package:medmark/homescreen.dart';
import 'package:medmark/search.dart';
import 'package:medmark/setup_exel.dart';
import 'package:medmark/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id : (context)=> HomeScreen(),
        AddPatient.id : (context) => AddPatient(),
        Display.id : (context) => Display(),
        SetupExel.id : (context) => SetupExel(),
        Search.id : (context) => Search(),
        Analyze.id : (context) => Analyze(),
      },
    );
  }
}


