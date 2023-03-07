import 'dart:async';
import 'dart:core';
import 'dart:math';

//import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';
import 'congratulations.dart';
import 'package:audioplayers/audioplayers.dart';

class HIITTimer extends StatefulWidget {
  @override
  _HIITTimer createState() => new _HIITTimer();
}

class _HIITTimer extends State<HIITTimer> {
  Duration countdownDuration = Duration(minutes: 0);
  Duration duration = Duration();
  Timer? timer;

  var player = AudioCache();
  final thisPlayer = AudioPlayer();

  bool finished = false;

  bool isStartingUp = true;
  bool isExercising = false;
  bool isResting = false;
  bool isBetweenExercises = false;

  Duration countdownDurationTotal = Duration(minutes: 0);
  Duration durationTotal = Duration();
  Timer? timerTotal;

  bool countDown = true;
  int exerciseNumber = 0;

  int timeOn = 0;
  int timeOff = 0;
  int totalSets = 0;
  int currentSet = 0;
  int currentExercise = 0;
  int totalExercise = 0;
  int totalTime = 0;
  int timeBetweenExercises = 0;
  int timeBeforeSession = 0;

  @override
  void initState() {
    super.initState();
    this.getPrefs();
    Wakelock.enable();
    //reset();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          title: new Text(
            'HIIT',
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
              Navigator.of(context).pop();
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          height: 1.sh,
          width: 1.sw,
          child: SingleChildScrollView(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 0.15.sh,
                  ),
                  buildTime(),
                  SizedBox(
                    height: 0.04.sh,
                  ),
                  getTitleLine(),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  getSetNumberLine(),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  buildTimeTotal(),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  buildButtons(),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                ]),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/light_background2.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ));
  }

  void dispose() {
    super.dispose();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //exerciseNumber = prefs.getInt("hiitExercises") ?? 4;
    timeOn = prefs.getInt("hiitTimerTimeOn") ?? 10;
    timeOff = prefs.getInt("hiitTimerTimeOff") ?? 10;
    totalSets = prefs.getInt("hiitTimerNumberOfExerciseSets") ?? 4;
    exerciseNumber = prefs.getInt("hiitTimerNumberOfExercises") ?? 4;
    timeBetweenExercises = prefs.getInt("hiitTimerTimeBetweenExercises") ?? 10;
    timeBeforeSession = prefs.getInt("hiitTimerTimeSetup") ?? 10;
    totalExercise = exerciseNumber;

    totalTime = timeBeforeSession +
        (timeOn * exerciseNumber * totalSets) +
        ((exerciseNumber - 1) * timeBetweenExercises) +
        ((totalSets - 1) * timeOff * exerciseNumber);

    countdownDurationTotal = Duration(seconds: totalTime);
    durationTotal = Duration(seconds: totalTime);

    countdownDuration = Duration(seconds: timeBeforeSession);
    duration = Duration(seconds: timeBeforeSession);

    setState(() {});
  }

  void reset() {
    if (countDown) {
      setState(() {
        duration = countdownDuration;
        durationTotal = countdownDurationTotal;
      });
    } else {
      setState(() {
        duration = Duration();
        durationTotal = Duration();
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? 1 : 1;

    final seconds = duration.inSeconds - addSeconds;
    final secondsTotal = durationTotal.inSeconds - addSeconds;
    duration = Duration(seconds: seconds);
    durationTotal = Duration(seconds: secondsTotal);

    if (seconds == 3 || seconds == 2 || seconds == 1) {
      _playSound("sounds/assets_pip.mp3");
    } else if (seconds == 0) {
      if (isStartingUp) {
        isStartingUp = false;
        isExercising = true;
        currentSet = 0;
        duration = Duration(seconds: timeOn);
        _playSound("sounds/assets_dingdingding.mp3");
      } else if (isResting) {
        isResting = false;
        isExercising = true;
        currentSet++;
        duration = Duration(seconds: timeOn);
        _playSound("sounds/assets_boop.mp3");
      } else if (isExercising && currentSet < (totalSets - 1)) {
        isExercising = false;
        isResting = true;
        isBetweenExercises = false;
        duration = Duration(seconds: timeOff);
        _playSound("sounds/assets_boop.mp3");
      } else if (isExercising &&
          currentSet == (totalSets - 1) &&
          currentExercise < (totalExercise - 1)) {
        isExercising = false;
        isBetweenExercises = true;
        currentSet = 0;
        duration = Duration(seconds: timeBetweenExercises);
        _playSound("sounds/assets_dingdingding.mp3");
      } else if (isBetweenExercises) {
        isBetweenExercises = false;
        isExercising = true;
        currentSet = 0;
        currentExercise++;
        duration = Duration(seconds: timeOn);
        _playSound("sounds/assets_dingdingding.mp3");
      } else if (isExercising &&
          currentSet == (totalSets - 1) &&
          currentExercise == (totalExercise - 1)) {
        isExercising = false;
        _playSound("sounds/assets_dingdingding.mp3");

        stopTimer();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Congratulations(),
          ),
        );
      }
    }
    setState(() {});
  }

  Container getSetNumberLine() {
    String returnString1 = "";
    String returnString2 = "";

    if (isBetweenExercises) {
      returnString1 = "Set 1/" + totalSets.toString();
      returnString2 = "Exercise " +
          (2 + currentExercise).toString() +
          "/" +
          totalExercise.toString();
    } else {
      returnString1 =
          "Set " + (1 + currentSet).toString() + "/" + totalSets.toString();
      returnString2 = "Exercise " +
          (1 + currentExercise).toString() +
          "/" +
          totalExercise.toString();
    }
    return singleLineTextContainer(
        returnString1 + "    |    " + returnString2, 0.05.sw);
  }

  Container getTitleLine() {
    String returnString1 = "";

    if (isStartingUp || isBetweenExercises) {
      returnString1 = "GET READY";
    } else {
      if (isExercising) {
        returnString1 = "WORK";
      } else {
        returnString1 = "REST";
      }
    }
    return singleLineTextContainer(returnString1, 0.13.sw);
  }


  Container singleLineTextContainer(String thisText, double textSize) {
    return Container(
      child: Text(
        thisText,
        style: GoogleFonts.actor(
          fontSize: textSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
      timerTotal?.cancel();
    });
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = twoDigits(duration.inSeconds);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: seconds, header: 'SECONDS', total: false),
    ]);
  }

  Widget buildTimeTotal() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(durationTotal.inMinutes.remainder(60));
    final seconds = twoDigits(durationTotal.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: minutes, header: 'MINUTES', total: true),
      SizedBox(
        width: 0.04.sw,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS', total: true),
    ]);
  }

  Widget buildTimeCard(
      {required String time,
        required String header,
        required bool total}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(0.03.sw),
            decoration: getCardColour(total),
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: total ? Colors.white : Colors.black,
                fontSize: getTextSize(total),
              ),
            ),
          ),
        ],
      );

  BoxDecoration getCardColour(bool total) {
    if (!total) {
      if (isStartingUp) {
        return BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20));
      } else if (isExercising) {
        return BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(20));
      } else if (isResting) {
        return BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20));
      } else {
        return BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(20));
      }
    } else {
      return BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(
          0.035.sw,
        ),
      );
    }
  }

  Future _playSound(String sound) {
    //if (_settings.silentMode) {
    //  return Future.value();
    // }
    //thisPlayer.setSource(AssetSource(sound));
    return thisPlayer.play(AssetSource(sound) ,mode: PlayerMode.lowLatency);
    //return player.play(sound, mode: PlayerMode.LOW_LATENCY);
  }

  double getTextSize(bool isLarge) {
    if (!isLarge) {
      return 200;
    } else
      return 50;
  }

  Text getTimeCardHeader(bool isLarge, String header) {
    if (isLarge) {
      return Text(header, style: TextStyle(color: Colors.black45));
    } else
      return Text("");
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds <= 0;
    //final isCompleted = false;
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
