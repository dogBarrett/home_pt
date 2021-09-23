import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_pt/helpers/ad_helper.dart';
import 'package:home_pt/presentation/widgets/sets_sessions_difficulty.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_pt/globals.dart';

import 'circuit_difficulty.dart';

class HIITSelectExercises extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _HIITSelectExercises createState() =>
      new _HIITSelectExercises();
}

class _HIITSelectExercises extends State<HIITSelectExercises> {
  var randomNumber = new Random();

  // ignore: deprecated_member_use
  List<String> exerciseListHere = <String>[];
  int numberOfExercises = 0;
  int numberOfExerciseSets = 4;


  String exercise1 = "";
  String exercise2 = "";
  String exercise3 = "";
  String exercise4 = "";
  String exercise5 = "";
  String exercise6 = "";
  String exercise7 = "";
  String exercise8 = "";

  @override

  Widget build(BuildContext context) {


    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          title: new Text('HIIT Session'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16,
            ),
            onPressed: () {
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
                new Text("Number of Exercises"),
                new DropdownButton<int>(
                  isExpanded: true,
                  value: numberOfExerciseSets,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (newValue) {
                    numberOfExerciseSets = newValue!;
                    setState(() {});
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text("4"),
                      value: 4,
                    ),
                    DropdownMenuItem(
                      child: Text("5"),
                      value: 5,
                    ),
                    DropdownMenuItem(
                      child: Text("6"),
                      value: 6,
                    ),
                    DropdownMenuItem(
                      child: Text("7"),
                      value: 7,
                    ),
                    DropdownMenuItem(
                      child: Text("8"),
                      value: 8,
                    ),
                  ],
                ),
                new Container(
                  height: 20,
                ),
                new Text("Exercise Selection"),
                new Container(
                  height: 10,
                ),
                new Container(
                    child: SingleChildScrollView(
                      child: Column(
                      children: <Widget>[

                        getDropdownMenu(exercise1, 1),
                        new Container(
                          height: 10,
                        ),
                        getDropdownMenu(exercise2, 2),
                        new Container(
                          height: 10,
                        ),
                        getDropdownMenu(exercise3, 3),
                        new Container(
                          height: 10,
                        ),
                        getDropdownMenu(exercise4, 4),
                        new Container(
                          height: 10,
                        ),
                        checkDropdownMenu(exercise5, 5),
                        new Container(
                          height: 10,
                        ),
                        checkDropdownMenu(exercise6, 6),
                        new Container(
                          height: 10,
                        ),
                        checkDropdownMenu(exercise7, 7),
                        new Container(
                          height: 10,
                        ),
                        checkDropdownMenu(exercise8, 8),
                      ]

                      ),
                    ),
                  height: MediaQuery.of(context).size.height * 0.5,
                ),

                new Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new RaisedButton(
                            key: null,
                            onPressed: randomiseExercises,
                            color: const Color(0xFFe0e0e0),
                            child: new Text(
                              "Randomise",
                              style: new TextStyle(
                                  fontSize: 12.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto"),
                            )),
                        new RaisedButton(
                            key: null,
                            onPressed: continueButton,
                            color: const Color(0xFFe0e0e0),
                            child: new Text(
                              "Continue",
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
          padding: const EdgeInsets.all(40.0),
          alignment: Alignment.center,
        ));
  }

  void continueButton() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('hiitExercise1', exercise1);
    prefs.setString('hiitExercise2', exercise2);
    prefs.setString('hiitExercise3', exercise3);
    prefs.setString('hiitExercise4', exercise4);
    prefs.setString('hiitExercise5', exercise5);
    prefs.setString('hiitExercise6', exercise6);
    prefs.setString('hiitExercise7', exercise7);
    prefs.setString('hiitExercise8', exercise8);
    prefs.setInt('hiitExercises', numberOfExerciseSets);

    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => CircuitDifficulty(),
        ))
        .then((value) => setState(() {}));
  }

  void initState() {
    getExerciseList();
    setState(() {});
  }

  void getExerciseList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 0;

    do {
      if (prefs.getString("isSelected" + i.toString()) == "1" &&
          HIIT[i]) {
        exerciseListHere.add(exerciseNamePlural[i]);
      }
      i++;
    } while (i < numberOfExercisesToChooseFrom);
    numberOfExerciseSets = prefs.getInt("hiitExercises")!;
    numberOfExercises = exerciseListHere.length;
    randomiseExercises();

    setState(() {});
  }

  void randomiseExercises() {
    int count = numberOfExercises;
    List<int> ex = [0, 0, 0, 0, 0, 0, 0, 0];

    ex[0] = randomNumber.nextInt(count);
    do {
      ex[1] = randomNumber.nextInt(count);
    } while (ex[1] == ex[0]);
    do {
      ex[2] = randomNumber.nextInt(count);
    } while (ex[2] == ex[0] || ex[2] == ex[1]);
    do {
      ex[3] = randomNumber.nextInt(count);
    } while (ex[3] == ex[0] || ex[3] == ex[1] || ex[3] == ex[2]);
    do {
      ex[4] = randomNumber.nextInt(count);
    } while (ex[4] == ex[0] || ex[4] == ex[1] || ex[4] == ex[2] || ex[4] == ex[3]);
    do {
      ex[5] = randomNumber.nextInt(count);
    } while (ex[5] == ex[0] || ex[5] == ex[1] || ex[5] == ex[2] || ex[5] == ex[3] || ex[5] == ex[4]);
    do {
      ex[6] = randomNumber.nextInt(count);
    } while (ex[6] == ex[0] || ex[6] == ex[1] || ex[6] == ex[2] || ex[6] == ex[3] || ex[6] == ex[4] || ex[6] == ex[5]);
    do {
      ex[7] = randomNumber.nextInt(count);
    } while (ex[7] == ex[0] || ex[7] == ex[1] || ex[7] == ex[2] || ex[7] == ex[3] || ex[7] == ex[4] || ex[7] == ex[5] || ex[7] == ex[6]);

    exercise1 = exerciseListHere[ex[0]];
    exercise2 = exerciseListHere[ex[1]];
    exercise3 = exerciseListHere[ex[2]];
    exercise4 = exerciseListHere[ex[3]];
    exercise5 = exerciseListHere[ex[4]];
    exercise6 = exerciseListHere[ex[5]];
    exercise7 = exerciseListHere[ex[6]];
    exercise8 = exerciseListHere[ex[7]];

    setState(() {});
  }



  Container checkDropdownMenu(String exerciseNumber, int dropdownNumber){
    if (numberOfExerciseSets >= dropdownNumber){
      return getDropdownMenu(exerciseNumber, dropdownNumber);
    }
    else{
      return Container();
    };
  }
  Container getDropdownMenu(String exerciseNumber, int dropdownNumber) {
    return Container(
        child: DropdownButton<String>(
      value: exerciseNumber,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        exerciseNumber = newValue!;
        if (dropdownNumber == 1) {
          exercise1 = exerciseNumber;
        } else if (dropdownNumber == 2) {
          exercise2 = exerciseNumber;
        } else if (dropdownNumber == 3) {
          exercise3 = exerciseNumber;
        } else if (dropdownNumber == 4) {
          exercise4 = exerciseNumber;
        } else if (dropdownNumber == 5) {
          exercise5 = exerciseNumber;
        } else if (dropdownNumber == 6) {
          exercise6 = exerciseNumber;
        } else if (dropdownNumber == 7) {
          exercise7 = exerciseNumber;
        } else if (dropdownNumber == 8) {
          exercise8 = exerciseNumber;
        }

        //updateValues();
        setState(() {});
      },
      //items: deckOfCardsExercises()
      items: exerciseListHere.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));
  }


}
