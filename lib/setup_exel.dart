import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

String curEndPoint = 'None';



class SetupExel extends StatefulWidget {
  static const String id = 'setupexel';
  const SetupExel({Key? key}) : super(key: key);

  @override
  State<SetupExel> createState() => _SetupExelState();
}

class _SetupExelState extends State<SetupExel> {
  final List<String> titles = [
    'Copy Code',
    'Open SpreadSheet',
    'Paste code',
    'Deploy',
    'MakeChanges',
    'Copy and paste in the app',

  ];
  List<String> instructions = [
    'Open link given link and copy the code: \n\nhttps://tinyurl.com/prasunscript\nor\nhttps://github.com/jithinprem/appscript_exel_update/blob/master/appscript.js ',
    'Open a new google speradsheet set your sheet name "Sheet1" in the example, and then click on extensions then Apps script',
    'Paste code and save it\n\run the file',
    'On top right deploy the code and chose New Deployment',
    'Set The description and set the "who has access" to anyone\nclick on deploy',
    'copy the URL, this is your end point '
  ];
  TextEditingController endpointController = TextEditingController();
  String endpoint = 'NOT SET!';
  var myicon = Icons.not_interested_rounded;
  String statusText = 'end point not set !';
  Color myicon_color = Colors.redAccent;

  @override
  void initState() {
    super.initState();
    getMyString();
  }

  setEndPoint(String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('endpoint', endpoint);
    setState((){
      this.myicon_color = Colors.lightGreen;
      this.statusText = 'end point set :)';
    });

  }

  void getMyString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myString = prefs.getString('endpoint') ?? 'NOT SET!';
    setState(() {
      this.endpoint = myString;
      this.myicon = myString == 'NOT SET!' ? Icons.not_interested_rounded : Icons.verified;
      this.statusText = myString == 'NOT SET!' ? 'end point not set! follow instructions' : 'end point set :)';
      this.myicon_color = myString == 'NOT SET!' ? Colors.redAccent : Colors.lightGreen;
    });
    Return_set_notset_Icon();
  }

  void removeShared()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('endpoint');
    setState((){
      this.myicon = Icons.not_interested_rounded;
      this.myicon_color = Colors.redAccent;
      this.statusText = 'end point not set! follow instructions';
    });
  }

  Return_set_notset_Icon() {
    if (endpoint != 'NOT SET!') {
      myicon = Icons.not_interested_rounded;
    } else {
      myicon = Icons.verified;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 300,
                        // margin: EdgeInsets.symmetric(horizontal: 1),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  titles[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white60
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Image(
                                  //fit: BoxFit.contain,
                                  width: double.infinity,
                                  image: AssetImage('lib/assets/images/pic$index.png'),
                                  //fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                    title: Text(
                                     instructions[index],
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: endpointController,
                            decoration: InputDecoration(
                              labelText: 'Endpoint',
                              labelStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xec5b7793),
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey[900],
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: ListTile(
                              leading: Icon(
                                myicon,
                                color: myicon_color,
                              ),
                              title: Text(
                                statusText,
                                style: TextStyle(color: Colors.white60),
                              ),
                            trailing: TextButton(
                              child: Text('Remove', style: TextStyle(color: Colors.orangeAccent),),
                              onPressed: (){
                                //remove shared prefrence
                                removeShared();
                              },
                            ),
                          )
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (endpointController.text.length > 5) {
                                setEndPoint(endpointController.text.trim());
                                endpointController.clear();

                                setState(() {
                                  myicon = Icons.verified;
                                });
                              }
                            },
                            child: Text('set Excel endpoint'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xec5b7793)),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
