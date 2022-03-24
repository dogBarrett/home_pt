import 'dart:core';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_pt/presentation/widgets/deck_of_cards_select_exercises.dart';
import 'package:home_pt/presentation/widgets/sets_select_exercises2.dart';
//import 'package:home_pt/presentation/widgets/sets_select_exercises.dart';

import 'circuit_select_exercises.dart';
import 'exercise_selection.dart';
import 'hiit_select_exercises.dart';
import 'hiit_timer_setup.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);
  @override
  _MainMenu createState() => new _MainMenu();
}

class _MainMenu extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    var appBarHeight = AppBar().preferredSize.height;
    var paddingTop = MediaQuery.of(context).padding.top;
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.cog,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExerciseSelection(),
                ),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: new Container(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 0.01.sh,
                  top: appBarHeight + paddingTop,
                ),
                child: Text(
                  "Workouts",
                  style: GoogleFonts.merriweather(
                    fontSize: 28.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  openDeckOfCards();
                },
                child: getTile(0),

              ),
              GestureDetector(
                onTap: () {
                  openCircuit();
                },
                child: getTile(1),

              ),
              GestureDetector(
                onTap: () {
                  openHIIT();
                },
                child: getTile(2),
              ),
              GestureDetector(
                onTap: () {
                  openSets();
                },
                child: getTile(3),
              ),
              GestureDetector(
                onTap: () {
                  openHIITTimer();
                },
                child: getTile(4),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/light_background2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.only(left: 0.02.sh, right: 0.02.sh),
      ),
    );
  }

  /*void onClose() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectExercisesForDeckOfCards(),
      ),
    );
  }*/

  void openDeckOfCards() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeckOfCardsSelectExercises(),
      ),
    );
  }

  void openSets() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetsSelectExercises(),
      ),
    );
  }

  void openHIIT() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HIITSelectExercises(),
      ),
    );
  }

  void openHIITTimer() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HIITTimerSetup(),
      ),
    );
  }

  void openCircuit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CircuitSelectExercises(),
      ),
    );
  }

  Container getTile(int thisNumber) {
    String imageFile = "";
    String thisTitle = "";
    String thisExplanation = "";

    if (thisNumber == 0){
      imageFile = "assets/images/button4_result.jpg";
      thisTitle = "Deck of Cards";
      thisExplanation = "52 cards. 4 exercises. Surprise order. Surprise number of reps. Max effort.";
    }
    else if(thisNumber == 1){
      imageFile = "assets/images/button3_result.jpg";
      thisTitle = "Circuit";
      thisExplanation = "Circuit is a list of exercises to do in order going from top to bottom, then back to the top 5 times through.";
    }
    else if(thisNumber == 2){
      imageFile = "assets/images/button2_result.jpg";
      thisTitle = "HIIT Session";
      thisExplanation = "High Intensity Interval Training is max effort during work period, rest during rest period. MAX effort.";
    }
    else if(thisNumber == 3){
      imageFile = "assets/images/button1_result.jpg";
      thisTitle = "Sets";
      thisExplanation = "Repeat the same exercise the given number of times before moving to the next exercise.";
    }
    else if(thisNumber == 4){
      imageFile = "assets/images/button5_result.jpg";
      thisTitle = "HIIT Timer";
      thisExplanation = "Select your own HIIT timer values, and do your own HIIT session using the apps HIIT countdown timer.";
    }
    return Container(
      height: 0.4.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(0.05.sw),
      ),
      margin: EdgeInsets.only(bottom: 0.02.sh),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(0.05.sw),
            child: Container(
              height: 0.4.sh,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageFile),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.srcOver,
                  ),
                ),
              ),
              width: 1.sw,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              margin:
              EdgeInsets.only(left: 0.05.sw, top: 0.035.sh),
              child: Text(
                thisTitle,
                style: GoogleFonts.merriweather(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 0.8.sw,
              margin:
              EdgeInsets.only(left: 0.05.sw, bottom: 0.035.sh),
              child: Text(
                thisExplanation,
                style: TextStyle(
                  fontSize: 11.sp,
                  letterSpacing: 0.3,
                  wordSpacing: 1,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
