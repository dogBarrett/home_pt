import 'dart:core';
import 'dart:math';
import 'package:home_pt/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:home_pt/helpers/getCard.dart';
import 'package:home_pt/presentation/widgets/main_menu.dart';
import 'package:home_pt/presentation/widgets/deck_of_cards_select_exercises.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Congratulations extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _Congratulations createState() => new _Congratulations();
}

class _Congratulations extends State<Congratulations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: InkWell(
          child: Container(
            child: Image.asset(
              "assets/images/wellDone.jpg",
              fit: BoxFit.fill,
            ),
          ),
          onTap: () {
            buttonPressed();
          },
        ),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }

  void buttonPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MainMenu(),
      ),
    );
  }
}
