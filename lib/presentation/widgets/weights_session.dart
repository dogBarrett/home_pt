import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_pt/globals.dart';
import 'package:home_pt/presentation/widgets/sets_select_exercises2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';
import 'congratulations.dart';

class WeightsSession extends StatefulWidget {
  @override
  _WeightsSession createState() => new _WeightsSession();
}

class _WeightsSession extends State<WeightsSession> {
  @override
  int exerciseNumber = 0;
  int sessionDifficulty = 0;

  List<String> sessionDif = ["", "", "", ""];

  List<String> exercise = ["", "", "", "", "", "", "", ""];
  List<String> exerciseReps= ["", "", "", "", "", "", "", ""];
  List<String> exerciseExtras = ["", "", "", "", "", "", "", ""];
  List<int> exerciseNumbers = [0, 0, 0, 0, 0, 0, 0, 0];


  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: new Text(
          'Weights Session',
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
        body: SingleChildScrollView(

      child: new Container(
        height: 1.sh,
        width: 1.sw,



        child: new Column(

          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            singleLineText("Exercises", 32.0),
            Container(
              height: 0.05.sh,
            ),
            checkText(0),
            checkReps(0),
            checkExtras(0),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(1),
            checkReps(1),
            checkExtras(1),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(2),
            checkReps(2),
            checkExtras(2),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(3),
            checkReps(3),
            checkExtras(3),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(4),
            checkReps(4),
            checkExtras(4),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(5),
            checkReps(5),
            checkExtras(5),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(6),
            checkReps(6),
            checkExtras(6),
            SizedBox(
              height: 0.03.sh,
            ),
            checkText(7),
            checkReps(7),
            checkExtras(7),
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


      padding: const EdgeInsets.all(10.0),

      decoration: BoxDecoration(
        color: Colors.green,
        image: DecorationImage(
          image: AssetImage("assets/light_background2.jpg"),
          fit: BoxFit.fill,
        ),),)
    ));
  }

  initState() {
    super.initState();
    Wakelock.enable();
    getPrefs();
    //setState(() {});
  }

  Future getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    exerciseNumber = prefs.getInt("weightsExercises") ?? 0;
    exerciseNumbers[0] = prefs.getInt("weightsExercise1") ?? 0;
    exerciseNumbers[1] = prefs.getInt("weightsExercise2") ?? 0;
    exerciseNumbers[2] = prefs.getInt("weightsExercise3") ?? 0;
    exerciseNumbers[3] = prefs.getInt("weightsExercise4") ?? 0;
    exerciseNumbers[4] = prefs.getInt("weightsExercise5") ?? 0;
    exerciseNumbers[5] = prefs.getInt("weightsExercise6") ?? 0;
    exerciseNumbers[6] = prefs.getInt("weightsExercise7") ?? 0;
    exerciseNumbers[7] = prefs.getInt("weightsExercise8") ?? 0;

    for (int i = 0; i < exerciseNumber; i++){
      exercise[i] = exerciseList[exerciseNumbers[i]].exerciseNamePlural;
    }

    var rnd = Random();
    for (int i = 0; i < exerciseNumber; i++){
      bool lowRepsHere = false;
      bool highRepsHere = false;
      exerciseExtras[i] = "";

      if (exerciseList[i].lowReps && !exerciseList[i].highReps){
        lowRepsHere = true;
        highRepsHere = false;
      }

      else if (!exerciseList[i].lowReps && exerciseList[i].highReps){
        lowRepsHere = false;
        highRepsHere = true;
      }
      else {
        //randomise between 0 and 1, either (0) high reps or (1)low reps
        int highOrLow = rnd.nextInt(2);
        switch (highOrLow) {
          case 0:
            highRepsHere = true;
            lowRepsHere = false;
            break;
          case 1:
            highRepsHere = false;
            lowRepsHere = true;
            break;

        }
      }

      if (lowRepsHere){
        int repsInt = rnd.nextInt(5);
        switch (repsInt){
          case 0:
            exerciseReps[i] = "5 x 3";
            break;
          case 1:
            exerciseReps[i] = "5 x 5";
            break;
          case 2:
            exerciseReps[i] = "3 x 8";
            break;
          case 3:
            exerciseReps[i] = "4 x 8";
            break;
          case 4:
            exerciseReps[i] = "6 x 3";
            break;
        }
      }
      else{
        int repsInt = rnd.nextInt(6);
        switch (repsInt){
          case 0:
            exerciseReps[i] = "3 x 20";
            break;
          case 1:
            exerciseReps[i] = "3 x 15";
            break;
          case 2:
            exerciseReps[i] = "4 x 20";
            break;
          case 3:
            exerciseReps[i] = "3 x 12";
            break;
          case 4:
            exerciseReps[i] = "3 x 12-15";
            break;
          case 5:
            exerciseReps[i] = "4 x 10";
            break;
        }
        int extrasInt = rnd.nextInt(5);
        switch (extrasInt) {
          case 0:
            if (exerciseList[exerciseNumbers[i]].amrap) {
              exerciseExtras[i] = "AMRAP after last set";
            }
            break;
          case 1:
            if (exerciseList[exerciseNumbers[i]].dropSet) {
              exerciseExtras[i] = "Last set as a drop set";
            }
            break;
          case 2:
            if (exerciseList[exerciseNumbers[i]].timeUnderTension) {
              exerciseExtras[i] = "Last set time under tension";
            }
            break;
        }
      }
    }
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
    if (exerciseNumber > exNumber) {
      return getExerciseText(exNumber);
    } else {
      return Container();
    }
  }

  Container checkReps(int exNumber) {
    if (exerciseNumber > exNumber) {
      return getRepsText(exNumber);
    } else {
      return Container();
    }
  }

  Container checkExtras(int exNumber) {
    if (exerciseNumber > exNumber && exerciseExtras[exNumber] != "") {
      return getExtrasText(exNumber);
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

  Container getExerciseText(int exNumber) {
    String textHere = exercise[exNumber];

    return Container(
        child: Text(
      textHere,
      style: GoogleFonts.actor(
        fontSize: 0.05.sw,
        fontWeight: FontWeight.bold,
      ),
    ));
  }

  Container getRepsText(int exNumber) {
    String textHere = exerciseReps[exNumber];

    return Container(
        child: Text(
          textHere,
          style: GoogleFonts.actor(
            fontSize: 0.05.sw,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Container getExtrasText(int exNumber) {
    String textHere = exerciseExtras[exNumber];

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
