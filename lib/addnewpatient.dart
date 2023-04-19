import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medmark/homescreen.dart';
import 'package:medmark/patient_data.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'listgen.dart';
import 'user_repo_firestore.dart';



class AddPatient extends StatefulWidget {
  static const String id = 'addnew';
  const AddPatient({Key? key}) : super(key: key);

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  // constants

  // slider value
  dynamic v0=0, v1=0, v2=0, v3=0, v4=0, v5=0, v6=0, v7=0,v8=0;

  // the points for each (pain, tiredness...)
  List<dynamic> _slider_vals = [2.0, 2.0 , 2.0 ,2.0, 2.0, 2.0, 2.0, 2.0 ,2.0];

  // text controllers
  final _nameController = TextEditingController();
  final _patientIdController = TextEditingController();
  final _additionCommentController = TextEditingController();
  bool isLoading = false;

  // for keybord
  FocusNode _focusNode = FocusNode();




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Stack(
            children: [
              if (isLoading) Center(child: CircularProgressIndicator()),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              // logo goes here
                              Image.asset('lib/assets/images/logo.png', height: 100, width: 100,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Hi  Prasun P', style: TextStyle(fontSize: 20, color: Colors.white54),),
                                  Text('welcome to Medclk')
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6.0,right: 2.0, ),
                                  child: Focus(
                                    focusNode: _focusNode,
                                    child: TextField(

                                      controller: _patientIdController,
                                      decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Id',

                                    ),
                                ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6.0,left: 3.0, ),
                                  child: Focus(
                                    focusNode: _focusNode,
                                    child: TextField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Patient Name',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                      flex: 9,
                        child: ListAtt(
                          myList: [
                            ListTile(
                              title: Text('Pain', style: TextStyle(color: Colors.white70),),
                              subtitle: Text(''),
                              trailing: Text(_slider_vals[0].toString(), style: TextStyle(fontSize: 35, color: Colors.white70),),
                            ),
                            ListTile(
                              title: Text('Tiredness', style: TextStyle(color: Colors.white70),),
                              subtitle: Text('lack of energy', style: TextStyle(color: Color(0xFF41644A)),),
                              trailing: Text(_slider_vals[1].toString(), style: TextStyle(fontSize: 35, color: Colors.white70),),
                            ),
                            ListTile(
                              title: Text('Drowsiness', style: TextStyle(color: Colors.white70),),
                              subtitle: Text('feeling sleepy', style: TextStyle(color: Color(0xFF41644A)),),
                              trailing: Text(_slider_vals[2].toString(), style: TextStyle(fontSize: 35, color: Colors.white70),),
                            ),
                            ListTile(
                              title: Text('Nausea', style: TextStyle(color: Colors.white70),),
                              subtitle: Text(''),
                              trailing: Text(_slider_vals[3].toString(), style: TextStyle(fontSize: 35, color: Colors.white70),),
                            ),
                            ListTile(
                              title: Text('Lack of appetite', style: TextStyle(color: Colors.white70),),
                              subtitle: Text(''),
                              trailing: Text(_slider_vals[4].toString(), style: TextStyle(fontSize: 35, color: Colors.white70),),
                            ),
                            ListTile(
                              title: Text('Shortness of breath', style: TextStyle(color: Colors.white70),),
                              subtitle: Text('lack of energy', style: TextStyle(color: Color(0xFF41644A)),),
                              trailing: Text(_slider_vals[5].toString(), style: TextStyle(fontSize: 35, color: Colors.white70),),
                            ),
                            ListTile(
                              title: Text('Depression', style: TextStyle(color: Colors.white70),),
                              subtitle: Text('feeling sad', style: TextStyle(color: Color(0xFF41644A)),),
                              trailing: Text(_slider_vals[6].toString(), style: TextStyle(fontSize: 35, color: Colors.white70),),
                            ),
                            ListTile(
                              title: Text('Anxiety', style: TextStyle(color: Colors.white70),),
                              subtitle: Text('feeling nervous', style: TextStyle(color: Color(0xFF41644A)),),
                              trailing: Text(_slider_vals[7].toString(), style: TextStyle(fontSize: 35, color: Colors.white70),),
                            ),
                            //Color(0xc86e8dab)
                            ListTile(
                              title: Text('Well Being', style: TextStyle(color: Colors.white70),),
                              subtitle: Text('how you feel overall', style: TextStyle(color: Color(0xFF41644A)),),
                              trailing: Text(_slider_vals[8].toString(), style: TextStyle(fontSize: 35, color: Colors.white70),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 18),
                              child: TextField(
                                controller: _additionCommentController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Additional',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: ElevatedButton(
                                onPressed: () {
                                  _focusNode.unfocus();
                                  // checking if the the patient id and name is written or not
                                  if(_patientIdController.text.length > 0 && _nameController.text.length > 0){
                                    String add_cmt = _additionCommentController.text.length > 0 ? _additionCommentController.text : 'no comments';
                                    var addDataPat = AddPatientData(patient_id: _patientIdController.text.trim(), fullname: _nameController.text.trim(), painval: _slider_vals[0].toString(), tiredness: _slider_vals[1].toString(), drowsiness: _slider_vals[2].toString(), lack_aptitite: _slider_vals[4].toString(), shortness_breath: _slider_vals[5].toString(), depression: _slider_vals[6].toString(), anxiety: _slider_vals[7].toString(), nausea: _slider_vals[3].toString(), wellbeing: _slider_vals[8].toString(), additional_comment: add_cmt);
                                    setState(() {
                                      isLoading = true;
                                      _focusNode.unfocus();
                                      UserRepository().add_my_patient(addDataPat, context);
                                    });

                                  }
                                  else{
                                    // patient name and id not written create a alert popup
                                    print('nothing entered ');
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          backgroundColor: Colors.white70,
                                          icon: Icon(Icons.error, color: Colors.redAccent,size: 40,),
                                          title: Text('Name or Id not entered!', style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 24)),),
                                          content: Text('please enter name and id to continue.', style: GoogleFonts.roboto(),),
                                          actions: [
                                            TextButton(
                                              child: Text('OK', style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.black87)),),
                                              onPressed: (){
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                },
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                  }

                                },
                                child: Text('Submit it'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF41644A)),
                                ),
                              ),
                            ),
                          ],
                        )
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      ),

                      child: SfSlider(
                        min: 0,
                        max: 10,
                        value: _slider_vals[selectedIndex],
                        interval: 1,
                        stepSize: 1,
                        showTicks: false,
                        showLabels: false,
                        enableTooltip: true,
                        activeColor: Color(0xFF41644A),
                        inactiveColor: Colors.black38,
                        //minorTicksPerInterval: 1,
                        onChanged: (dynamic value) {

                          setState(() {

                            //_slider_vals[selectedIndex] = value;
                            _slider_vals[selectedIndex] = value;
                          });
                        },
                      ),
                    ),
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
