import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:home_pt/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:home_pt/helpers/getCard.dart';
import 'package:home_pt/presentation/widgets/select_exercises_for_deck_of_cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _MainMenu createState() => new _MainMenu();
}

class _MainMenu extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Colors.blueGrey, width: 2.0)))),
              onPressed: () {openDeckOfCards();},
              child: Container(
                height: MediaQuery.of(context).size.height / 7,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Deck of Cards Circuit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/images/manone.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Colors.blueGrey, width: 2.0)))),
              onPressed: () {},
              child: Container(
                height: MediaQuery.of(context).size.height / 7,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Circuit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/images/mantwo.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                          BorderSide(color: Colors.blueGrey, width: 2.0)))),
              onPressed: () {},
              child: Container(
                height: MediaQuery.of(context).size.height / 7,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'HIIT Circuit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/images/manthree.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                          BorderSide(color: Colors.blueGrey, width: 2.0)))),
              onPressed: () {},
              child: Container(
                height: MediaQuery.of(context).size.height / 7,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sets',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/images/manfour.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10.0),
      ),

    );
  }

  void onClose() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectExercisesForDeckOfCards(),
      ),
    );
  }

  void openDeckOfCards(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectExercisesForDeckOfCards(),
      ),
    );
  }
}