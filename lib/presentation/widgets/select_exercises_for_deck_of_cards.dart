import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:home_pt/helpers/getCard.dart';
import 'package:home_pt/helpers/exercises.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'deck_of_cards.dart';

class SelectExercisesForDeckOfCards extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _SelectExercisesForDeckOfCards createState() =>
      new _SelectExercisesForDeckOfCards();
}

class _SelectExercisesForDeckOfCards
    extends State<SelectExercisesForDeckOfCards> {
  @override
  int numberOfCardsLeft = 52;
  int currentCard = 53;


  late List<bool> hasBeenUsed = List.filled(52, false);

  var randomNumber = new Random();

  String exercise1 = "Burpees";
  String exercise2 = "Push ups";
  String exercise3 = "Squats";
  String exercise4 = "Sit-ups";

  Widget build(BuildContext context) {
    randomiseExercises();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Deck of Cards'),
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
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "Exercise Selection"),

                new Container(
                  height: 40,
                ),
                new DropdownButton<String>(
                  isExpanded: true,
                  value: exercise1,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (newValue) {
                      exercise1 = newValue.toString();
                      updateValues();
                      setState(() {

                      });
                  },
                  items: deckOfCardsExercises()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                new Container(
                  height: 10,
                ),
                new DropdownButton<String>(
                  value: exercise2,
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
                    setState(() {
                      exercise2 = newValue!;
                      updateValues();
                    });
                  },
                  items: deckOfCardsExercises()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                new Container(
                  height: 10,
                ),
                new DropdownButton<String>(
                  value: exercise3,
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

                      exercise3 = newValue!;
                      updateValues();
                      setState(() {
                    });
                  },
                  items: deckOfCardsExercises()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                new Container(
                  height: 10,
                ),
                new DropdownButton<String>(
                  value: exercise4,
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
                    setState(() {
                      exercise4 = newValue!;
                      updateValues();
                    });
                  },
                  items: deckOfCardsExercises()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                new Container(
                  height: 40,
                ),
                new Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        new RaisedButton(key:null, onPressed:randomiseExercises,
                            color: const Color(0xFFe0e0e0),
                            child:
                            new Text(
                              "Randomise",
                              style: new TextStyle(fontSize:12.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto"),
                            )
                        ),

                        new RaisedButton(key:null, onPressed:continueButton,
                            color: const Color(0xFFe0e0e0),
                            child:
                            new Text(
                              "Continue",
                              style: new TextStyle(fontSize:12.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto"),
                            )
                        ),
                      ]

                  ),
                ),
              ]),

          padding: const EdgeInsets.all(60.0),
          alignment: Alignment.center,
        ));
  }

  void updateValues() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deckOfCardsExercise1', exercise1);
    prefs.setString('deckOfCardsExercise2', exercise2);
    prefs.setString('deckOfCardsExercise3', exercise3);
    prefs.setString('deckOfCardsExercise4', exercise4);

  }

  void randomiseExercises(){
    int count = deckOfCardsExercises().length;
    List<int> ex = [0, 0, 0, 0];
    int currentInt = 0;

    ex[0] = randomNumber.nextInt(count);
    do{
      ex[1] = randomNumber.nextInt(count);
    }while (ex[1] == ex[0]);
    do{
      ex[2] = randomNumber.nextInt(count);
    }while (ex[2] == ex[0] || ex[2] == ex[1]);
    do{
      ex[3] = randomNumber.nextInt(count);
    }while (ex[3] == ex[0] || ex[3] == ex[1] || ex[3] == ex[2]);

    exercise1 = getDeckOfCardsExercises(ex[0]);
    exercise2 = getDeckOfCardsExercises(ex[1]);
    exercise3 = getDeckOfCardsExercises(ex[2]);
    exercise4 = getDeckOfCardsExercises(ex[3]);
    setState(() {

    });
    updateValues();

  }

  void continueButton(){
    updateValues();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeckOfCards(),
      ),
    );

  }
}
