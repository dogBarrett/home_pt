import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
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
        backgroundColor: Colors.transparent,
        title: new Text('Circuit'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 16,
          ),
          onPressed: () {
            reset();
            stopTimer();
            //dispose();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: new Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                "5 TIMES THROUGH",
                style: new TextStyle(
                    fontSize: 32.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w800,
                    fontFamily: "Roboto"),
              ),
              Container(
                height: 10,
              ),
              checkText(1),
              checkText(2),
              checkText(3),
              checkText(4),
              checkText(5),
              checkText(6),
              checkText(7),
              checkText(8),
              buildTime(),
              SizedBox(
                height: 10,
              ),
              buildButtons(),
              new Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new RaisedButton(
                          key: null,
                          onPressed: () {
                            finishSetsSession();
                          },
                          color: const Color(0xFFe0e0e0),
                          child: new Text(
                            "Finish Session",
                            style: new TextStyle(
                                fontSize: 12.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto"),
                          )),
                    ]),
              ),
            ]),
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
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(header, style: TextStyle(color: Colors.black45)),
        ],
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = false;
    return isRunning || isCompleted
        ? Row(
            //return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  text: 'STOP',
                  onClicked: () {
                    if (isRunning) {
                      stopTimer(resets: false);
                    }
                  }),
            ],
          )
        : ButtonWidget(
            text: "Start Timer!",
            color: Colors.black,
            backgroundColor: Colors.white,
            onClicked: () {
              startTimer();
            });
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
        style: new TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF000000),
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto"),
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
      ));
}
