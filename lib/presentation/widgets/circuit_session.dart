import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_pt/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';
import 'circuit_select_exercises.dart';
import 'congratulations.dart';

class CircuitSession extends StatefulWidget {
  @override
  _CircuitSession createState() => new _CircuitSession();
}

class _CircuitSession extends State<CircuitSession> {
  @override
  int exerciseNumber = 0;
  int sessionDifficulty = 0;

  List<String> sessionDif = ["", "", "", ""];

  List<String> exercise = ["", "", "", "", "", "", "", ""];

  static const countdownDuration = Duration(minutes: 0);
  Duration duration = Duration();
  Timer? timer;

  bool countDown = true;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: new Text(
          'Circuit',
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
            reset();
            stopTimer();
            //dispose();
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
            SizedBox(
              height: 0.06.sh,
            ),
            new Text(
              "5 TIMES THROUGH",
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                fontSize: 25.sp,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 0.06.sh,
            ),
            checkText(1),
            SizedBox(
              height: 0.02.sh,
            ),
            checkText(2),
            SizedBox(
              height: 0.02.sh,
            ),
            checkText(3),
            SizedBox(
              height: 0.02.sh,
            ),
            checkText(4),
            SizedBox(
              height: 0.02.sh,
            ),
            checkText(5),
            SizedBox(
              height: 0.02.sh,
            ),
            checkText(6),
            SizedBox(
              height: 0.02.sh,
            ),
            checkText(7),
            SizedBox(
              height: 0.02.sh,
            ),
            checkText(8),
            SizedBox(
              height: 0.06.sh,
            ),
            buildTime(),
            SizedBox(
              height: 0.03.sh,
            ),
            buildButtons(),
            SizedBox(
              height: 0.035.sh,
            ),
            new Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new GestureDetector(
                      onTap: finishSetsSession,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 0.015.sh,
                          horizontal: 0.04.sw,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(
                            0.02.sw,
                          ),
                        ),
                        width: 0.35.sw,
                        child: new Text(
                          "Finish Session",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 0.038.sw,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "Roboto",
                          ),
                        ),
                      )),
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

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    reset();

    getPrefs();
    //setState(() {});
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? 1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //buildTimeCard(time: hours, header:'HOURS'),
      //SizedBox(width: 8,),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(0.03.sw),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade900,
              borderRadius: BorderRadius.circular(
                0.035.sw,
              ),
            ),
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 0.15.sw,
              ),
            ),
          ),
          SizedBox(
            height: 0.01.sh,
          ),
          Text(header, style: TextStyle(color: Colors.black45)),
        ],
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = false;
    return isRunning || isCompleted
        ? new GestureDetector(
            onTap: () {
              if (isRunning) {
                stopTimer(resets: false);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 0.02.sh,
                horizontal: 0.06.sw,
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(
                  0.02.sw,
                ),
              ),
              width: 0.45.sw,
              child: new Text(
                "Stop!",
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  fontSize: 0.05.sw,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : new GestureDetector(
            onTap: startTimer,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 0.02.sh,
                horizontal: 0.06.sw,
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(
                  0.02.sw,
                ),
              ),
              width: 0.45.sw,
              child: new Text(
                "Start Timer!",
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  fontSize: 0.05.sw,
                  color: Colors.white,
                ),
              ),
            ),
          );
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
    exerciseNumber = prefs.getInt("circuitExercises") ?? 0;
    sessionDifficulty = prefs.getInt("circuitDifficulty") ?? 0;
    exercise[0] = prefs.getString("circuitExercise1") ?? "";
    exercise[1] = prefs.getString("circuitExercise2") ?? "";
    exercise[2] = prefs.getString("circuitExercise3") ?? "";
    exercise[3] = prefs.getString("circuitExercise4") ?? "";
    exercise[4] = prefs.getString("circuitExercise5") ?? "";
    exercise[5] = prefs.getString("circuitExercise6") ?? "";
    exercise[6] = prefs.getString("circuitExercise7") ?? "";
    exercise[7] = prefs.getString("circuitExercise8") ?? "";

    getSessionDif(exerciseNumber);

    setState(() {});
  }

  void openSets() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CircuitSelectExercises(),
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

    return Container(
      child: Text(
        textHere,
        style: GoogleFonts.actor(
          fontSize: 0.05.sw,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void finishSetsSession() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Congratulations(),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onClicked,
      this.color = Colors.white,
      this.backgroundColor = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
        onPressed: onClicked,
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: color),
        ),
      );
}
