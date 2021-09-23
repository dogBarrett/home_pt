import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:home_pt/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:home_pt/helpers/getCard.dart';
import 'package:home_pt/presentation/widgets/deck_of_cards_select_exercises.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_menu.dart';

class LoadingPage extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _LoadingPage createState() => new _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  @override
  initState() {
    super.initState();
    Timer(const Duration(seconds: 5), onClose);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 300,
                child: new Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fill,
                ),
              ),
            ]),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }

  void onClose() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MainMenu(),
      ),
    );
  }
}
