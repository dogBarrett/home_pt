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
                child: Container(
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
                              image: AssetImage("assets/images/button4.jpg"),
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
                        bottom: 0,
                        left: 0,
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 0.05.sw, bottom: 0.08.sh),
                          child: Text(
                            'Deck of Cards',
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
                            '52 cards. 4 exercises. Surprise order. Surprise number of reps. Max effort.',
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
                ),
              ),
              GestureDetector(
                onTap: () {
                  openCircuit();
                },
                child: Container(
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
                              image: AssetImage("assets/images/button3.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.srcOver),
                            ),
                          ),
                          width: 1.sw,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 0.05.sw, bottom: 0.08.sh),
                          child: Text(
                            'Circuit',
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
                            'Circuit is a list of exercises to do in order going from top to bottom, then back to the top 5 times through.',
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
                ),
              ),
              GestureDetector(
                onTap: () {
                  openHIIT();
                },
                child: Container(
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
                              image: AssetImage("assets/images/button2.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.srcOver),
                            ),
                          ),
                          width: 1.sw,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 0.05.sw, bottom: 0.08.sh),
                          child: Text(
                            'HIIT Session',
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
                            'High Intensity Interval Training is max effort during work period, rest during rest period. MAX effort ',
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
                ),
              ),
              GestureDetector(
                onTap: () {
                  openSets();
                },
                child: Container(
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
                              image: AssetImage("assets/images/button1.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.srcOver),
                            ),
                          ),
                          width: 1.sw,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 0.05.sw, bottom: 0.08.sh),
                          child: Text(
                            'Sets',
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
                            'Repeat the same exercise the given number of times before moving to the next exercise.',
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
                ),
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

  void openCircuit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CircuitSelectExercises(),
      ),
    );
  }
}
