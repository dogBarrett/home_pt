import 'dart:core';
import 'dart:math';
import 'package:home_pt/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:home_pt/helpers/getCard.dart';
import 'package:home_pt/presentation/widgets/select_exercises_for_deck_of_cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Congratulations extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _Congratulations createState() => new _Congratulations();
}

class _Congratulations extends State<Congratulations> {
  @override
  Widget build(BuildContext context) {

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
        child:
        new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                height: 400,
                child: new Image.asset(
                  "assets/images/wellDone.jpg",
                  fit: BoxFit.fill,
                ),
              ),

              new RaisedButton(key: null, onPressed: buttonPressed,
                  color: const Color(0xFFe0e0e0),
                  child:
                  new Text(
                    "Exit",
                    style: new TextStyle(fontSize: 12.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  )
              )
            ]

        ),

        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }

  void buttonPressed(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectExercisesForDeckOfCards(),
      ),
    );

  }
}