import 'package:flutter/material.dart';
import 'package:medmark/addnewpatient.dart';
import 'package:medmark/analyze.dart';
import 'package:medmark/search.dart';
import 'package:medmark/setup_exel.dart';
import 'package:medmark/test.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

// to show if the endpoint is set or not
String endpointAlert = 'Exel endpoint not set !';
IconData setIcon = Icons.error;
Color setColor = Colors.redAccent;

// class for graph display in the card widget
class DataPoint {
  final double x;
  final double y;

  DataPoint({required this.x, required this.y});
}
// datapoints contain the sample data to plot the graphic graph (used just for viewing purpose) if you get an image replace this with image
List<DataPoint> dataPoints = [];


class HomeScreen extends StatefulWidget {
  static const String id = 'homescreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variables
  String formattedDate = '';
  String formattedDay = '';


  @override
  void initState() {
    // Call the super class' initState() method
    super.initState();

    // Your initialization code goes here
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
    formattedDay = DateFormat('EEEE').format(now);

    // check if endpoint is set or not
    checkEndpointExist();
  }
  

  // get data from shared prefrence
  checkEndpointExist() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String myString = prefs.getString('endpoint') ?? 'none';
    if(myString != 'none'){
      setState(() {
        setIcon = Icons.verified;
        setColor = Colors.green;
        endpointAlert = 'Exel Endpoint set';

      });
    }else{
      setState(() {
        setIcon = Icons.error;
        setColor = Colors.redAccent;
        endpointAlert = 'Exel Endpoint not set';
      });
    }
  }

  void takeToAdd() {
    Navigator.pushNamed(context, AddPatient.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.black38,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'lib/assets/images/logo.png',
                                height: 150,
                                width: 150,
                              ),
                              Positioned(
                                top: 90,
                                left: 22,
                                child: Text(
                                  'medclk',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 28, bottom: 17, left: 17, right: 17),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  formattedDay,
                                  style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey[500], letterSpacing: .5, fontWeight: FontWeight.bold, fontSize: 29),),),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(formattedDate, style: GoogleFonts.breeSerif(),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Add',
                        style: GoogleFonts.lato(textStyle : TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),),
                      tileColor: Colors.grey[600],
                      subtitle: Text('add patient data', style: GoogleFonts.lato(),),
                      leading: Icon(Icons.add),
                      onTap: takeToAdd,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                        title: Text(
                          'Search',
                          style: GoogleFonts.lato(textStyle : TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                        tileColor: Colors.grey[700],
                        subtitle: Text('plot data', style: GoogleFonts.lato()),
                        leading: Icon(Icons.search),
                        onTap: () {
                          Navigator.pushNamed(context, Search.id);
                        }),
                  ),

                ],
              ),
              GestureDetector(
                onTap: (){
                  print('card was clicked');
                  // open analyze
                  Navigator.pushNamed(context,Analyze.id);
                },
                child: Card(
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            'Analyze trends',
                            style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.white38),
                          ),
                          tileColor: Colors.grey[900],
                        ),
                        Container(
                          child: Image.asset('lib/assets/images/graph.png', height: 120, width: 500,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ListTile(
                      //leading: Icon(setIcon, color: setColor,),
                      //title: Text(endpointAlert, style: GoogleFonts.lato()),
                      leading: Icon(Icons.note_add, color: Colors.white38,),
                      title: Text('Update Endpoint', style: GoogleFonts.lato(color: Colors.white38),),
                      subtitle: Text('instructions to set endpoint', style: GoogleFonts.lato(),),
                      tileColor: Colors.grey[900],
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white54,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, SetupExel.id);
            },
            backgroundColor: Colors.black38,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.content_paste, color: Colors.white54,),
                Text('Add Exel', style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: Colors.white70)),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
