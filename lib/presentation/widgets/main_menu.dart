import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_pt/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:home_pt/helpers/getCard.dart';
import 'package:home_pt/presentation/widgets/deck_of_cards_select_exercises.dart';
import 'package:home_pt/presentation/widgets/sets_select_exercises2.dart';
//import 'package:home_pt/presentation/widgets/sets_select_exercises.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'circuit_select_exercises.dart';
import 'deck_of_cards_settings.dart';
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
    double appBarHeight = MediaQuery.of(context).padding.top;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            size: 16,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ExerciseSelection(),
              ),
            );
          },
        ),
      ),
      body: new Container(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                // style: ButtonStyle(
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(18.0),
                //             side: BorderSide(color: Colors.black, width: 2.0)))),
                onTap: () {
                  openDeckOfCards();
                },
                child: Container(
                  height: 0.2.sh,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/button4.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(18.0),

                    //color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(15.0),
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Deck of Cards',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      /*Image.asset(
                        "assets/images/manone.png",
                        fit: BoxFit.fitHeight,
                      ),*/
                    ],
                  ),
                ),
              ),
              GestureDetector(
                // style: ButtonStyle(
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(18.0),
                //             side: BorderSide(color: Colors.black, width: 2.0)))),
                onTap: () {
                  openCircuit();
                },
                child: Container(
                  //height: MediaQuery.of(context).size.height / 7,
                  height: 0.2.sh,
                  width: 1.sw,
                  padding: const EdgeInsets.all(15.0),
                  margin: EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/button3.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(18.0),
                    //color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Circuit',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      /*Image.asset(
                        "assets/images/mantwo.png",
                        fit: BoxFit.fitHeight,
                      ),*/
                    ],
                  ),
                ),
              ),
              GestureDetector(
                // style: ButtonStyle(
                //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //     RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(18.0),
                //       side: BorderSide(color: Colors.black, width: 2.0),
                //     ),
                //   ),
                // ),
                onTap: () {
                  openHIIT();
                },
                child: Container(
                  height: 0.2.sh,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/button2.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(18.0),
                    // border: Border.all(
                    //   color: Colors.black,
                    //   width: 2.0,
                    // ),
                    //color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(15.0),
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'HIIT Session',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      /*Image.asset(
                        "assets/images/manthree.png",
                        fit: BoxFit.fitHeight,
                      ),*/
                    ],
                  ),
                ),
              ),
              GestureDetector(
                // style: ButtonStyle(
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(18.0),
                //             side: BorderSide(color: Colors.black, width: 2.0)))),
                onTap: () {
                  openSets();
                },
                child: Container(
                  height: 0.2.sh,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/button1.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(18.0),
                    //color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(15.0),
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Sets',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      /*Image.asset(
                        "assets/images/manfour.png",
                        fit: BoxFit.fitHeight,
                      ),*/
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
        padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
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
