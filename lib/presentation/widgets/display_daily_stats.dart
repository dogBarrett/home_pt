import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_pt/presentation/widgets/display_progress_chart.dart';
import 'package:home_pt/presentation/widgets/progress_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../../globals.dart';
import 'main_menu.dart';

class DisplayDailyStats extends StatefulWidget {
  @override
  _DisplayDailyStats createState() => _DisplayDailyStats();
}

class _DisplayDailyStats extends State<DisplayDailyStats> {
  List<DailyMeasurements> thisDailyMeasurements = [];

  //String? jsonStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('View Daily Stats'), actions: [
          IconButton(
            icon: Icon(
              Icons.bar_chart,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayProgressChart(),
                ),
              );
            },
          ),
        ]),
        body: Center(
            child: ListView(children: [
          thisDataTable(globalDailyMeasurements),
        ])));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future getPrefs() async {}

  DataTable thisDataTable(List<DailyMeasurements> thisDailyMeasurements) {
    return DataTable(
      //columnSpacing: .3.sw,

      columns: const [
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Weight')),
        DataColumn(label: Text('Fat %')),
      ],
      rows: thisDailyMeasurements
          .map((dailyMeasurements) => DataRow(cells: [
                DataCell(
                  InkWell(
                    child: Container(
                      //width: 1.sw,
                      child: Text(DateFormat("dd MMM yyyy")
                          .format(DateTime.parse(dailyMeasurements.thisDate))),
                    ),
                    onTap: () {
                      checkForDeletion(dailyMeasurements.thisDate);
                    },
                  ),
                ),
                DataCell(Text(dailyMeasurements.thisWeight.toString())),
                DataCell(Text(dailyMeasurements.thisFatPercent.toString())),
              ]))
          .toList(),
    );
  }

  Future<void> checkForDeletion(String thisDate) async {

    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                //backgroundColor: Colors.transparent,
                child: Container(

                  height: 0.2.sh,
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                  //width: 1.sw,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                  Text("Do you want to delete this entry?"),
                  ElevatedButton(
                    child: Container(
                        //width: 1.sw,
                        child: Text("Yes, delete the entry")),
                    onPressed: () {deleteEntry(thisDate);},
                  ),
                ])));
          });
        });
  }
  void deleteEntry(String thisDate){
    int returnIndex = 0;

    for (int i = 0; i < globalDailyMeasurements.length; i++) {
      //do something
      if (globalDailyMeasurements[i].thisDate == thisDate){
        returnIndex = i;
      }
    }
    globalDailyMeasurements.removeAt(returnIndex);
    setPrefs();
    Fluttertoast.showToast(
        msg: "Data deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) => MainMenu()), (route) => false);
  }

  Future<void> writeDailyMeasurements(
      List<DailyMeasurements> dailyMeasurements) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert List<DailyMeasurement> to List<Map<String, dynamic>>
    List<Map<String, dynamic>> mapList =
    dailyMeasurements.map((dm) => dm.toJson()).toList();

    // Encode List<Map<String, dynamic>> to JSON string and save to shared preference
    String jsonStr = jsonEncode(mapList);

    prefs.setString('jsonDailyMeasurements', jsonStr);
  }

  void setPrefs() async {
    writeDailyMeasurements(globalDailyMeasurements);

  }
}
