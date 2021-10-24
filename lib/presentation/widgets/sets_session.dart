import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_pt/globals.dart';
import 'package:home_pt/presentation/widgets/sets_select_exercises2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';
import 'congratulations.dart';

class SetsSession extends StatefulWidget {
  @override
  _SetsSession createState() => new _SetsSession();
}

class _SetsSession extends State<SetsSession> {
  @override
  int exerciseNumber = 0;
  int sessionDifficulty = 0;

  List<String> sessionDif = ["", "", "", ""];

  List<String> exercise = ["", "", "", "", "", "", "", ""];

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: new Text(
          'Sets Session',
          style: GoogleFonts.merriweather(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 0.024.sh,
          ),
          onPressed: () {
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
            singleLineText("5 SETS OF EACH", 32.0),
            Container(
              height: 0.05.sh,
            ),
            checkText(1),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(2),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(3),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(4),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(5),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(6),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(7),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(8),
            SizedBox(
              height: 0.03.sh,
            ),
            new Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      finishSetsSession();
                    },
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
                      width: 0.35.sw,
                      child: new Text(
                        "Finish Session",
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
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/light_background2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.all(10.0),
      ),
    );
  }

  initState() {
    Wakelock.enable();
    getPrefs();
    //setState(() {});
  }

  void getSessionDif(int setsNumber) {
    if (sessionDifficulty == 1) {
      sessionDif[0] = "1 x ";
      sessionDif[1] = "2 x ";
      sessionDif[2] = "5 x ";
      sessionDif[3] = "10 sec ";
    } else if (sessionDifficulty == 2) {
      sessionDif[0] = "2 x ";
      sessionDif[1] = "5 x ";
      sessionDif[2] = "10 x ";
      sessionDif[3] = "15 sec ";
    } else if (sessionDifficulty == 3) {
      sessionDif[0] = "5 x ";
      sessionDif[1] = "10 x ";
      sessionDif[2] = "20 x ";
      sessionDif[3] = "30 sec ";
    } else if (sessionDifficulty == 4) {
      sessionDif[0] = "10 x ";
      sessionDif[1] = "20 x ";
      sessionDif[2] = "30 x ";
      sessionDif[3] = "60 sec ";
    } else if (sessionDifficulty == 5) {
      sessionDif[0] = "15 x ";
      sessionDif[1] = "25 x ";
      sessionDif[2] = "50 x ";
      sessionDif[3] = "90 sec ";
    }
  }

  Future getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    exerciseNumber = prefs.getInt("setsSessionExercises") ?? 0;
    sessionDifficulty = prefs.getInt("setsSessionDifficulty") ?? 0;
    exercise[0] = prefs.getString("setsSessionExercise1") ?? "";
    exercise[1] = prefs.getString("setsSessionExercise2") ?? "";
    exercise[2] = prefs.getString("setsSessionExercise3") ?? "";
    exercise[3] = prefs.getString("setsSessionExercise4") ?? "";
    exercise[4] = prefs.getString("setsSessionExercise5") ?? "";
    exercise[5] = prefs.getString("setsSessionExercise6") ?? "";
    exercise[6] = prefs.getString("setsSessionExercise7") ?? "";
    exercise[7] = prefs.getString("setsSessionExercise8") ?? "";

    getSessionDif(exerciseNumber);

    setState(() {});
  }

  void openSets() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetsSelectExercises(),
      ),
    );
  }

  Container checkText(int exNumber) {
    if (exerciseNumber >= exNumber) {
      return getText(exNumber);
    } else {
      return Container();
    }
  }

  Text singleLineText(String thisText, double textSize) {
    return Text(
      thisText,
      style: GoogleFonts.merriweather(
        fontSize: textSize.sp,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Container getText(int exNumber) {
    String textHere = "";
    int circuitNo = 0;
    int thisCctNumber = 0;

    int i = 0;
    do {
      if (exerciseNamePlural[i] == exercise[exNumber - 1]) {
        thisCctNumber = i;
        circuitNo = circuitNumber[thisCctNumber];
      }
      i++;
    } while (i != numberOfExercisesToChooseFrom);

    textHere = sessionDif[circuitNo - 1] + exercise[exNumber - 1];
    ;

    return Container(
        child: Text(
      textHere,
      style: GoogleFonts.actor(
        fontSize: 0.05.sw,
      ),
    ));
  }

  void finishSetsSession() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Congratulations(),
      ),
    );
  }

  void dispose() {
    Wakelock.disable();
    super.dispose();
  }
}
