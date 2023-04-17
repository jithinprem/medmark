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
              Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.black38,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                ),

                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Image.asset('lib/assets/images/logo.png', height: 150, width: 150,),
                            Positioned(
                              top: 90,
                              left: 22,
                              child: Text(
                                'medclk',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(onPressed: takeToAdd, child: Text('add')),
                  ElevatedButton(onPressed: (){Navigator.pushNamed(context, Search.id);}, child: Text('search')),
                  ElevatedButton(onPressed: (){Navigator.pushNamed(context, SetupExel.id);}, child: Text('instructions')),

                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}
