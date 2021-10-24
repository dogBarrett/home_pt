import 'dart:core';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_pt/globals.dart' as globals;
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';
import 'package:home_pt/helpers/ad_helper.dart';
import 'package:home_pt/helpers/getCard.dart';
import 'package:home_pt/presentation/widgets/congratulations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wakelock/wakelock.dart';

class DeckOfCards extends StatefulWidget {
  DeckOfCards({Key? key}) : super(key: key);
  @override
  _DeckOfCards createState() => new _DeckOfCards();
}

class _DeckOfCards extends State<DeckOfCards> {
  @override
  int numberOfCardsLeft = 52;
  int currentCard = 53;
  String ex1 = "";
  String ex2 = "";
  String ex3 = "";
  String ex4 = "";

  List<bool> hasBeenUsed = List.filled(52, false);

  var randomNumber = new Random();

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: new Text(
          'Deck of Cards',
          style: GoogleFonts.merriweather(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 0.024.sh,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: new Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _getCardsLeftText(),
              new Container(
                height: 0.035.sh,
              ),
              new InkWell(
                child: Container(
                  child: _getCardImage(),
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                onTap: () {
                  if (numberOfCardsLeft > 1) {
                    do {
                      currentCard = randomNumber.nextInt(52);
                    } while (hasBeenUsed[currentCard]);
                    numberOfCardsLeft--;
                    hasBeenUsed[currentCard] = true;

                    setState(() {});
                  } else
                    finishDeckOfCards();
                },
              ),
              new Container(
                height: 0.035.sh,
              ),
              _getExercisesLeft(),
            ]),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/light_background2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(0.04.sw),
        alignment: Alignment.center,
      ),
    );
  }

  void finishDeckOfCards() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Congratulations(),
      ),
    );
  }

  Widget _getCardsLeftText() {
    return Text(
      numerousOrSingleCardLeft(),
      style: GoogleFonts.merriweather(
        fontSize: 20.sp,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  String numerousOrSingleCardLeft() {
    if (numberOfCardsLeft == 52) {
      return "Touch cards to begin session";
    } else {
      if (numberOfCardsLeft > 1) {
        return numberOfCardsLeft.toString() + " cards left";
      } else
        return "Last card";
    }
  }

  Widget _getCardImage() {
    return Image.asset(
      getCardImageText(currentCard),
      fit: BoxFit.contain,
    );
  }

  Widget _getExercisesLeft() {
    return Text(
      getTextForBottomText(),
      style: GoogleFonts.merriweather(
        fontSize: 20.sp,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  String getTextForBottomText() {
    if (numberOfCardsLeft == 52) {
      return "Touch cards to begin session";
    } else {
      return "" +
          getNumberOfReps(currentCard).toString() +
          " x " +
          getExercise();
    }
  }

  String getExercise() {
    String returnValue;
    if (currentCard < 13) {
      returnValue = ex1;
    } else if (currentCard > 12 && currentCard < 26) {
      returnValue = ex2;
    } else if (currentCard > 25 && currentCard < 39) {
      returnValue = ex3;
    } else {
      returnValue = ex4;
    }

    return returnValue;
  }

  void getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ex1 = prefs.getString('deckOfCardsExercise1') ?? "";
    ex2 = prefs.getString('deckOfCardsExercise2') ?? "";
    ex3 = prefs.getString('deckOfCardsExercise3') ?? "";
    ex4 = prefs.getString('deckOfCardsExercise4') ?? "";
  }

  // TODO: Implement _loadInterstitialAd()

  void initState() {
    Wakelock.enable();
    getPreferences();
    setState(() {});
  }

  void dispose() {
    Wakelock.disable();
    super.dispose();
  }
}
