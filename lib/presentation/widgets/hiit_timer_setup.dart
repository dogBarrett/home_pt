import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_pt/helpers/ad_helper.dart';
import 'package:home_pt/presentation/widgets/sets_sessions_difficulty.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_pt/globals.dart';

import 'circuit_difficulty.dart';
import 'hiit_timer.dart';

class HIITTimerSetup extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _HIITTimerSetup createState() => new _HIITTimerSetup();
}

class _HIITTimerSetup extends State<HIITTimerSetup> {
  // ignore: deprecated_member_use
  int numberOfExercises = 0;
  int numberOfExerciseSets = 0;
  int timeOn = 0;
  int timeOff = 0;
  int timeBetweenExercises = 0;
  int timeSetup = 0;

  List<int> time = [0, 0, 0, 0, 0, 0, 0, 0, 0];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          title: new Text(
            'HIIT Timer',
            style: GoogleFonts.merriweather(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              setPrefs();
              Navigator.of(context).pop();
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body: new Container(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    bottom: 0.01.sh,
                  ),
                  child: Text(
                    "HIIT Timer Setup",
                    style: GoogleFonts.merriweather(
                      fontSize: 20.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 0.45.sh),
                  child: new Container(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            getDropdownCountMenu("Number of exercises", 1),
                            new Container(
                              height: 10,
                            ),
                            getDropdownCountMenu("Number of exercise sets", 2),
                            new Container(
                              height: 10,
                            ),
                            getDropdownTimeMenu("Setup time", 3),
                            new Container(
                              height: 10,
                            ),
                            getDropdownTimeMenu("Time between exercises", 4),
                            new Container(
                              height: 10,
                            ),
                            getDropdownTimeMenu("Time on", 5),
                            new Container(
                              height: 10,
                            ),
                            getDropdownTimeMenu("Time off", 6),
                            new Container(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(top: 0.03.sh),
                  width: 1.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: continueButton,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0.015.sh,
                            horizontal: 0.04.sw,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade900,
                            borderRadius: BorderRadius.circular(
                              0.03.sw,
                            ),
                          ),
                          width: 0.3.sw,
                          child: new Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 0.038.sw,
                              color: Colors.white,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/light_background2.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
        ));
  }

  void continueButton() async {
    setPrefs();
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => HIITTimer(),
        ))
        .then((value) => setState(() {}));
  }

  void setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('hiitTimerNumberOfExercises', time[0]);
    prefs.setInt('hiitTimerNumberOfExerciseSets', time[1]);
    prefs.setInt('hiitTimerTimeOn', time[4]);
    prefs.setInt('hiitTimerTimeOff', time[5]);
    prefs.setInt('hiitTimerTimeBetweenExercises', time[3]);
    prefs.setInt('hiitTimerTimeSetup', time[2]);

  }

  void initState() {
    getPrefs();
    setState(() {});
  }

  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    numberOfExerciseSets = prefs.getInt("hiitTimerNumberOfExerciseSets") ?? 4;
    numberOfExercises = prefs.getInt("hiitTimerNumberOfExercises") ?? 4;
    timeOn = prefs.getInt("hiitTimerTimeOn") ?? 10;
    timeOff = prefs.getInt("hiitTimerTimeOff") ?? 10;
    timeBetweenExercises = prefs.getInt("hiitTimerTimeBetweenExercises") ?? 10;
    timeSetup = prefs.getInt("hiitTimerTimeSetup") ?? 10;

    time[0] = numberOfExercises;
    time[1] = numberOfExerciseSets;
    time[2] = timeSetup;
    time[3] = timeBetweenExercises;
    time[4] = timeOn;
    time[5] = timeOff;

    setState(() {});
  }

  Container getDropdownCountMenu(String valueDescription, int dropdownNumber) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 0.7.sw,
            padding: EdgeInsets.fromLTRB(0.01.sw, 0, 0, 0),
            child: Text(valueDescription),
          ),
          Container(
              width: 0.2.sw,
              child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.03.sw,
                    vertical: 0.00.sh,
                  ),
                  //margin: EdgeInsets.only(top: 0.015.sh),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.03.sw),
                    border: Border.all(
                      width: 0.002.sw,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: time[dropdownNumber - 1],
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24.sp,
                      elevation: 16,
                      style: TextStyle(color: Colors.blueGrey.shade900),
                      onChanged: (int? newValue) {
                        time[dropdownNumber - 1] = newValue!;
                        setState(() {});
                      },
                      items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                          .map((int value) {
                        return new DropdownMenuItem<int>(
                          value: value,
                          child: new Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ))),
        ],
      ),
      alignment: Alignment.center,
    );
  }

  Container getDropdownTimeMenu(String valueDescription, int dropdownNumber) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 0.7.sw,
            padding: EdgeInsets.fromLTRB(0.01.sw, 0, 0, 0),
            child: Text(valueDescription),
          ),
          Container(
              width: 0.2.sw,
              child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.03.sw,
                    vertical: 0.00.sh,
                  ),
                  //margin: EdgeInsets.only(top: 0.015.sh),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.03.sw),
                    border: Border.all(
                      width: 0.002.sw,
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: time[dropdownNumber - 1],
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24.sp,
                      elevation: 16,
                      style: TextStyle(color: Colors.blueGrey.shade900),
                      onChanged: (int? newValue) {
                        time[dropdownNumber - 1] = newValue!;
                        setState(() {});
                      },
                      items: <int>[5, 10, 15, 20, 25, 30, 40, 45, 50, 60]
                          .map((int value) {
                        return new DropdownMenuItem<int>(
                          value: value,
                          child: new Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ))),
        ],
      ),
      alignment: Alignment.center,
    );
  }
}
