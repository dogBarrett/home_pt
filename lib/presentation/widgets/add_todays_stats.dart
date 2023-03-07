import 'package:flutter/material.dart';
import 'package:home_pt/globals.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'main_menu.dart';

class AddTodaysStats extends StatefulWidget {
  @override
  _AddTodaysStats createState() => _AddTodaysStats();
}

class _AddTodaysStats extends State<AddTodaysStats> {
  String _selectedDate = new DateFormat("dd MMM yyyy").format(DateTime.now());
  String _jsonSelectedDate =
      new DateFormat('yyyy-MM-dd').format(DateTime.now());
  final weightTextController = TextEditingController();
  final fatPercentageTextController = TextEditingController();

  List<String> jsonStringList = [];

  Future _selectDate() async {
    DateTime? now = DateTime.now();
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2040));
    if (picked != null) {
      setState(() {
        _selectedDate = new DateFormat("dd-MM-yyyy").format(picked);
        _jsonSelectedDate = new DateFormat('yyyy-MM-dd').format(picked);
      });
    } else {
      setState(() {
        _selectedDate = new DateFormat("dd-MM-yyyy").format(now);
        _jsonSelectedDate = new DateFormat('yyyy-MM-dd').format(now);
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    weightTextController.dispose();
    fatPercentageTextController.dispose();

    super.dispose();
  }

  initState() {
    super.initState();
    getPrefs();
    //setState(() {});
  }

  void getPrefs() async {
    readDailyMeasurements();
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

  Future readDailyMeasurements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Read JSON string from shared preference
    String? jsonStr = prefs.getString('jsonDailyMeasurements');

    // If there's no existing data, return an empty list
    if (jsonStr == null) {
      return [];
    }
// Parse JSON string to List<Map<String, dynamic>>
    List<dynamic> jsonList = jsonDecode(jsonStr);
    List<Map<String, dynamic>> mapList =
        List<Map<String, dynamic>>.from(jsonList);

    globalDailyMeasurements =
        mapList.map((map) => DailyMeasurements.fromJson(map)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Daily Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_selectedDate,
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                      size: 0.02.sh,
                    ),
                    onPressed: _selectDate,
                  ),
                ],
              ),
              Container(
                height: 0.1.sh,
              ),
              Text("Weight (kg)",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.white24,
                    width: 0.2.sw,
                    child: TextField(
                      controller: weightTextController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                height: 0.1.sh,
              ),
              Text("Fat Percent (%)",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 0.2.sw,
                    color: Colors.white24,
                    child: TextField(
                      controller: fatPercentageTextController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                height: 0.05.sh,
              ),
              ElevatedButton(onPressed: onPressed, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() {
    //check that values are in weight and fat percentage

    bool weightEntered = false;
    bool fatPercentEntered = false;

    if (weightTextController.text.isNotEmpty) {
      weightEntered = true;
    }
    if (fatPercentageTextController.text.isNotEmpty) {
      fatPercentEntered = true;
    }
    if (!weightEntered || !fatPercentEntered) {
      Fluttertoast.showToast(
          msg: "Please enter data in both fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    int i = 0;
    bool hasBeenDone = false;
    if (globalDailyMeasurements.length > 0) {
      do {
        if (globalDailyMeasurements[i].thisDate == _jsonSelectedDate) {
          hasBeenDone = true;
        }
        i++;
      } while (i < globalDailyMeasurements.length);
    }

    if (hasBeenDone && weightEntered && fatPercentEntered) {
      //data already entered for this date
      Fluttertoast.showToast(
          msg: "Data already entered for this date",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      globalDailyMeasurements.add(DailyMeasurements(
          thisDate: _jsonSelectedDate,
          thisWeight: double.parse(weightTextController.text),
          thisFatPercent: double.parse(fatPercentageTextController.text)));
      globalDailyMeasurements.sort((a, b) => a.thisDate.compareTo(b.thisDate));
      setPrefs();
      Fluttertoast.showToast(
          msg: "Data entered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainMenu()),
          (route) => false);
    }
    //}
  }
}
