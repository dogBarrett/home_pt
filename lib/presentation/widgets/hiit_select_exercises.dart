import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_pt/helpers/ad_helper.dart';
import 'package:home_pt/presentation/widgets/sets_sessions_difficulty.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_pt/globals.dart';

import 'circuit_difficulty.dart';
import 'hiit_difficulty.dart';

class HIITSelectExercises extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _HIITSelectExercises createState() =>
      new _HIITSelectExercises();
}

class _HIITSelectExercises extends State<HIITSelectExercises> {
  var randomNumber = new Random();

  // ignore: deprecated_member_use
  List<String> exerciseList = <String>[];
  int numberOfExercises = 0;
  int numberOfExerciseSets = 4;

  List<String> exercises = ["", "", "", "", "", "", "", ""];

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
              setPrefs();
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

                        getDropdownMenu(exercises[0], 1),
                        new Container(
                          height: 10,
                        ),
                        getDropdownMenu(exercises[1], 2),
                        new Container(
                          height: 10,
                        ),
                        getDropdownMenu(exercises[2], 3),
                        new Container(
                          height: 10,
                        ),
                        getDropdownMenu(exercises[3], 4),
                        new Container(
                          height: 10,
                        ),
                        checkDropdownMenu(exercises[4], 5),
                        new Container(
                          height: 10,
                        ),
                        checkDropdownMenu(exercises[5], 6),
                        new Container(
                          height: 10,
                        ),
                        checkDropdownMenu(exercises[6], 7),
                        new Container(
                          height: 10,
                        ),
                        checkDropdownMenu(exercises[7], 8),
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
    setPrefs();
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => HIITDifficulty(),
        ))
        .then((value) => setState(() {}));
  }

  void setPrefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('hiitExercise1', exercises[0]);
    prefs.setString('hiitExercise2', exercises[1]);
    prefs.setString('hiitExercise3', exercises[2]);
    prefs.setString('hiitExercise4', exercises[3]);
    prefs.setString('hiitExercise5', exercises[4]);
    prefs.setString('hiitExercise6', exercises[5]);
    prefs.setString('hiitExercise7', exercises[6]);
    prefs.setString('hiitExercise8', exercises[7]);
    prefs.setInt('hiitExercises', numberOfExerciseSets);

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
        exerciseList.add(exerciseNamePlural[i]);
      }
      i++;
    } while (i < numberOfExercisesToChooseFrom);
    numberOfExerciseSets = prefs.getInt("hiitExercises")?? 4;
    numberOfExercises = exerciseList.length;
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

    int numberHere = 0;
    do{
      exercises[numberHere] = exerciseList[ex[numberHere]];
      numberHere++;
    }while (numberHere < 8);

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
        exercises[(dropdownNumber - 1)] = exerciseNumber;

        setState(() {});
      },
      //items: deckOfCardsExercises()
      items: exerciseList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));
  }


}
