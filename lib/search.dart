import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


// class used by the graph to show
class PatientData {
  final String category;
  final int value;
  PatientData(this.category, this.value);
}
List<Color> bluePalette = [
  Color(0xFFEFF7FB),
  Color(0xFFD7EFFB),
  Color(0xFFBEE7FB),
  Color(0xFFA5DFFF),
  Color(0xFF8DC7FF),
  Color(0xFF74BFFF),
  Color(0xFF5DA5DA),
  Color(0xFF4A8AC6),
  Color(0xFF386FAF),
  Color(0xFF255494),
];

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  static const String id = 'searchpage';

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // class variable
  TextEditingController patientIdController = TextEditingController();

  // normal variables
  String username = 'Hello Prasun';
  String userid = 'welcome';


  // lists
  List<Map<String, dynamic>> detailList = [];
  List<DocumentSnapshot> _searchResults = [];
  List<PatientData> patientDataList = [];
  List<List<PatientData>> totalPatientList = [];



  // function to retrive the firebase data of the patient
  patientFiredata(String id) async {
    // the async method
    final fireinst = FirebaseFirestore.instance
        .collection('patient')
        .doc(id)
        .collection('date');
    final QuerySnapshot dateDocs = await fireinst.get();

    setState(() {
      _searchResults = dateDocs.docs;
    });

    if (dateDocs.docs.isNotEmpty) {
      // if the date sub-collection is not empty, print data for each date
      for (final dateDoc in dateDocs.docs) {
        final String date = dateDoc.id;
        final String name = dateDoc.get('name');
        final String additional_comments = dateDoc.get('additional_comments');
        final String anxiety = dateDoc.get('anxiety');
        final String best_wellbeing = dateDoc.get('best_wellbeing');
        final String depression = dateDoc.get('depression');
        final String drowsiness = dateDoc.get('drowsiness');
        final String lack_appetite = dateDoc.get('lack_appetite');
        final String nausea = dateDoc.get('nausea');
        final String pain = dateDoc.get('pain');
        final String shortness_breath = dateDoc.get('shortness_breath');
        final String tiredness = dateDoc.get('tiredness');
        print('Date: $date, Data: $name');
        setState(() {
          username = name;
          userid = 'patient Id : ' + id;
        });

        // create a dictionary and add values
        this.detailList.add({
          'date': dateDoc.id,
          'name': dateDoc.get('name'),
          'additional_comments': dateDoc.get('additional_comments'),
          'anxiety': dateDoc.get('anxiety'),
          'best_wellbeing': dateDoc.get('best_wellbeing'),
          'depression': dateDoc.get('depression'),
          'drowsiness': dateDoc.get('drowsiness'),
          'lack_appetite': dateDoc.get('lack_appetite'),
          'nausea': dateDoc.get('nausea'),
          'pain': dateDoc.get('pain'),
          'shortness_breath': dateDoc.get('shortness_breath'),
          'tiredness': dateDoc.get('tiredness'),
        });
        print('value of the pain is : '+  pain);
        this.patientDataList = [
          PatientData('pain 🤕', double.parse(pain).toInt()),
          PatientData('drowsiness', double.parse(drowsiness).toInt()),
          PatientData('anxiety 😰', double.parse(anxiety).toInt()),
          PatientData('depression', double.parse(depression).toInt()),
          PatientData('nausea', double.parse(nausea).toInt()),
          PatientData('short 😮‍💨', double.parse(shortness_breath).toInt()),
          PatientData('tiredness', double.parse(tiredness).toInt()),
          PatientData('lack 😋', double.parse(lack_appetite).toInt()),
          PatientData('wellbeing', double.parse(best_wellbeing).toInt()),
        ];

        totalPatientList.add(this.patientDataList);

      }
    } else {
      // if the date subcollection is empty, the patient data for all dates does not exist
      print('Patient data for all dates not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: patientIdController,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              detailList.clear();
              patientFiredata(value);
            },
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Perform search functionality here
                  detailList.clear();
                  patientFiredata(patientIdController.text.toString());
                }),
          ],
        ),
        body: Column(children: <Widget>[
          ListTile(
            title: Text(username, style: TextStyle(color: Colors.white24, fontSize: 26),),
            subtitle: Text('${userid}'),
            tileColor: Colors.black38,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: this.detailList.length,
              itemBuilder: (context, index) {
                // String name = this.detailList[index]['name'];
                String date = this.detailList[index]['date'];
                String? name = this.detailList[index]['name'];
                String? additional_comments = this.detailList[index]['additional_comments'];
                String? anxiety = this.detailList[index]['anxiety'];
                String? best_wellbeing = this.detailList[index]['best_wellbeing'];
                String? depression = this.detailList[index]['depression'];
                String? drowsiness = this.detailList[index]['drowsiness'];
                String? lack_appetite = this.detailList[index]['lack_appetite'];
                String? nausea = this.detailList[index]['nausea'];
                String? pain = this.detailList[index]['pain'];
                String? shortness_breath =
                    this.detailList[index]['shortness_breath'];
                String? tiredness = this.detailList[index]['tiredness'];

                return Card(
                  child: Center(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        labelRotation: 310, // rotate the labels by 90 degrees
                      ),
                      title: ChartTitle(text: 'Dated :' + date, textStyle: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w700, fontSize: 12)),
                      series: <ChartSeries>[
                        ColumnSeries<PatientData, String>(
                          dataSource: this.totalPatientList[index],
                          xValueMapper: (PatientData data, _) => data.category,
                          yValueMapper: (PatientData data, _) => data.value,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          pointColorMapper: (PatientData data, _) => bluePalette[data.value]
                          ,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
