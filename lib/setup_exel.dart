import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    'Open AppScripts',
    'Paste code',
    'MakeChanges',
    'Save and Run',
    'Deploy',
    'Deploy instruction',
    'Copy endpoint'
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
                flex: 5,
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
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/images/pic$index.png',
                                fit: BoxFit.cover,
                              ),
                              ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'open the link and copy the code written with all your strength so that you can defeat the enemy\n and if '
                                      'he comes again go and take out the sword'),
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
