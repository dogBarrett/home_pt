import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_pt/helpers/ad_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_pt/globals.dart';

import 'deck_of_cards.dart';

class DeckOfCardsSelectExercises extends StatefulWidget {
  DeckOfCardsSelectExercises({Key? key}) : super(key: key);
  @override
  _DeckOfCardsSelectExercises createState() =>
      new _DeckOfCardsSelectExercises();
}

class _DeckOfCardsSelectExercises extends State<DeckOfCardsSelectExercises> {
  var randomNumber = new Random();

  List<String> exerciseListHere = <String>[];
  int numberOfExercises = 0;

  bool isInitialised = false;

  List<String> exercises = ["", "", "", ""];

  @override
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  // TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  Widget build(BuildContext context) {
    // TODO: Load an Interstitial Ad
    if (!_isInterstitialAdReady) {
      _loadInterstitialAd();
    }

    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
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
                new Text("Exercise Selection"),
                new Container(
                  height: 0.040.sh,
                ),
                getDropdownMenu(exercises[0], 1),
                new Container(
                  height: 0.010.sh,
                ),
                getDropdownMenu(exercises[1], 2),
                new Container(
                  height: 0.010.sh,
                ),
                getDropdownMenu(exercises[2], 3),
                new Container(
                  height: 10,
                ),
                getDropdownMenu(exercises[3], 4),
                new Container(
                  height: 40,
                ),
                new Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
          padding: const EdgeInsets.all(60.0),
          alignment: Alignment.center,
        ));
  }

  void continueButton() {
    // TODO: Display an Interstitial Ad
    if (_isInterstitialAdReady) {
      _interstitialAd?.show();
    }
    updateValues();
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => DeckOfCards(),
        ))
        .then((value) => setState(() {}));
  }

  void initState() {
    super.initState();
    getExerciseList();
    setState(() {});
  }

  void getExerciseList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 0;

    do {
      if (prefs.getString("isSelected" + i.toString()) == "1" &&
          deckOfCards[i]) {
        exerciseListHere.add(exerciseNamePlural[i]);
      }
      i++;
    } while (i < numberOfExercisesToChooseFrom);
    numberOfExercises = exerciseListHere.length;
    randomiseExercises();

    setState(() {});
  }

  void updateValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deckOfCardsExercise1', exercises[0]);
    prefs.setString('deckOfCardsExercise2', exercises[1]);
    prefs.setString('deckOfCardsExercise3', exercises[2]);
    prefs.setString('deckOfCardsExercise4', exercises[3]);
    setState(() {});
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {});
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  void randomiseExercises() {
    int count = numberOfExercises;
    List<int> ex = [0, 0, 0, 0];

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

    int numberHere = 0;
    do {
      exercises[numberHere] = exerciseListHere[ex[numberHere]];
      numberHere++;
    } while (numberHere < 4);
    setState(() {});
  }

  void dispose() {
    // COMPLETE: Dispose an InterstitialAd object
    _interstitialAd?.dispose();

    super.dispose();
  }

  Container getDropdownMenu(String exerciseNumber, int dropdownNumber) {
    String cardSuit = "";

    return Container(
        child: DropdownButton<String>(
      value: exerciseNumber,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24.sp,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        exerciseNumber = newValue!;
        exercises[dropdownNumber - 1] = exerciseNumber;
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
