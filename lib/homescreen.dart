import 'package:flutter/material.dart';
import 'package:medmark/addnewpatient.dart';
import 'package:medmark/search.dart';
import 'package:medmark/setup_exel.dart';
import 'package:medmark/test.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homescreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void takeToAdd(){
    Navigator.pushNamed(context, AddPatient.id);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('MEDIC ', style: TextStyle(fontSize: 32,),),
                  Text('CK'),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(onPressed: takeToAdd, child: Text('add')),
                  ElevatedButton(onPressed: (){Navigator.pushNamed(context, Search.id);}, child: Text('search')),
                  ElevatedButton(onPressed: (){Navigator.pushNamed(context, SetupExel.id);}, child: Text('instructions')),

                ],
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text('History'),
                    leading: Icon(Icons.history, color: Colors.white,),
                    tileColor: Colors.black38,
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
