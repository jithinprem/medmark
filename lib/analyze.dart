import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medmark/homescreen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Analyze extends StatefulWidget {
  const Analyze({Key? key}) : super(key: key);
  static const String id = 'Analyze';

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class PatientData{
  final label;
  final value;
  PatientData({required this.label, required this.value});
}

class _AnalyzeState extends State<Analyze> {

  // normal variables
  String username = 'Hi';
  String userid = 'welcome';

  // controller to take id for search
  TextEditingController IdController = TextEditingController();

  // list to store data
  List<Map<String, dynamic>> detailList = [];
  List<PatientData> painList = [];
  List<PatientData> drowsinessList = [];
  List<PatientData> anxietyList = [];
  List<PatientData> depressionList = [];
  List<PatientData> nauseaList = [];
  List<PatientData> short_b_List = [];
  List<PatientData> tirednessList = [];
  List<PatientData> lackAppetiteList = [];
  List<PatientData> wellbeingList = [];

  List<List<PatientData>> totalList = [];

  List<String> categories = ['pain', 'drowsiness', 'anxiety', 'depression', 'nausea', 'shortness breath', 'tiredness', 'lack appetite', 'well being'];


  // make date more readable
  getlab(String data){
    List<String> realdate = data.split('-');
    List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug','Sep', 'Oct', 'Nov', 'Dec'];
    return realdate[0] + ' ' + months[int.parse(realdate[1])];

  }

  // function to retrive the firebase data of the patient
  patientAnalyze(String id) async {
    // the async method
    final fireinst = FirebaseFirestore.instance.collection('patient').doc(id).collection('date');
    final QuerySnapshot dateDocs = await fireinst.get();

    if (dateDocs.docs.isNotEmpty) {
      // if the date sub-collection is not empty, print data for each date
      for (final dateDoc in dateDocs.docs) {
        final String date = dateDoc.id;
        final String name = dateDoc.get('name');

        print('Date: $date, Data: $name');
        setState(() {
          username = name;
          userid = 'patient Id : ' + id;
        });

        print('we are reaching the first stage');

        this.painList.add(PatientData(label: dateDoc.id, value: double.parse(dateDoc.get('pain'))));
        print('painval : '+ dateDoc.get('pain'));
        this.drowsinessList.add(PatientData(label: dateDoc.id, value: double.parse(dateDoc.get('drowsiness'))));
        print('drowsiness : '+ dateDoc.get('drowsiness'));
        this.anxietyList.add(PatientData(label: dateDoc.id, value: double.parse(dateDoc.get('anxiety'))));
        print('anxiety : '+ dateDoc.get('anxiety'));
        this.depressionList.add(PatientData(label: dateDoc.id, value: double.parse(dateDoc.get('depression'))));
        print('depression : '+ dateDoc.get('depression'));
        this.nauseaList.add(PatientData(label: dateDoc.id, value: double.parse(dateDoc.get('nausea'))));
        print('nausea : '+ dateDoc.get('nausea'));
        this.short_b_List.add(PatientData(label: dateDoc.id, value: double.parse(dateDoc.get('shortness_breath'))));
        print('sb : '+ dateDoc.get('shortness_breath'));
        this.tirednessList.add(PatientData(label: dateDoc.id, value: double.parse(dateDoc.get('tiredness'))));
        print('tiredness : '+ dateDoc.get('tiredness'));
        this.lackAppetiteList.add(PatientData(label: dateDoc.id, value: double.parse(dateDoc.get('lack_appetite'))));
        print('lack_appetite : '+ dateDoc.get('lack_appetite'));
        this.wellbeingList.add(PatientData(label: dateDoc.id, value: double.parse(dateDoc.get('best_wellbeing'))));
        print('best well : ' + dateDoc.get('best_wellbeing'));

        print('we finished the first stage');

        print('painlist object');
        print(painList);

      }
    } else {
      // if the date subcollection is empty, the patient data for all dates does not exist
      print('Patient data for all dates not found');
    }

    this.totalList = [this.painList, this.depressionList, this.anxietyList, this.depressionList, this.nauseaList, this.short_b_List, this.tirednessList, this.lackAppetiteList, this.wellbeingList];
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: IdController,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              this.totalList.clear();
              this.painList.clear();
              print('the chagned value is : ' + value);
              patientAnalyze(value);
              print(painList.length.toString() + ' this is the lenght of pain list for real');
            },
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Perform search functionality here
                  totalList.clear();
                  //print('wanted length totalList[0]: ' + totalList[0].length.toString());
                  patientAnalyze(IdController.text.toString());
                  print(painList.length.toString() + ' this is the lenght of pain list for real');

                }),
          ],
        ),
       //body: Center(child: Text('helloworld')),
        body: Column(
          children: <Widget>[

            ListTile(
              title: Text(this.username,style: GoogleFonts.lato()),
              subtitle: Text(this.userid, style: GoogleFonts.lato()),
              trailing: Text('Analyze conditon', style: GoogleFonts.lato(),),
              leading: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(Icons.graphic_eq, color: Colors.white38,),
              ),
              tileColor: Color(0xB541644A),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: totalList.length,
                itemBuilder: (context, index){
                  return SizedBox(
                    height: 240,
                    child: Card(
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          labelRotation: 310, // rotate the labels by 90 degrees
                        ),
                        title: ChartTitle(text: categories[index], textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12, fontFamily: 'sans-serif')),
                        series: <ChartSeries>[
                          LineSeries<PatientData, String>(
                            dataSource: this.totalList[index],
                            xValueMapper: (PatientData data, _) => getlab(data.label),
                            yValueMapper: (PatientData data, _) => data.value,
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                            enableTooltip: true,
                            color: Colors.black38,
                            pointColorMapper: (PatientData data, _) => Colors.green,
                          ),
                        ],
                      ),
                    ),
                  );
                }

              ),
            ),

          ],
        ),//*/
      ),
    );
  }
}
