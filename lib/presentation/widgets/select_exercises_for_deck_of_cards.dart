import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_pt/helpers/ad_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_pt/globals.dart';

import 'deck_of_cards.dart';

class SelectExercisesForDeckOfCards extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _SelectExercisesForDeckOfCards createState() =>
      new _SelectExercisesForDeckOfCards();
}

class _SelectExercisesForDeckOfCards
    extends State<SelectExercisesForDeckOfCards> {

  var randomNumber = new Random();

  // ignore: deprecated_member_use
  List<String> exerciseListHere = <String>[];
  int numberOfExercises = 0;

  bool isInitialised = false;

  String exercise1 = "";
  String exercise2 = "";
  String exercise3 = "";
  String exercise4 = "";

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

      print(exerciseListHere);
      print (numberOfExercises);

      return new Scaffold(
          appBar: new AppBar(
            /*flexibleSpace: Image(
            image: AssetImage('assets/gradient_background.png'),
            fit: BoxFit.cover,
          ),*/
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
                      setState(() {});
                    },
                    //items: deckOfCardsExercises()
                    items: exerciseListHere
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
                    exercise2 = newValue!;
                    updateValues();
                    setState(() {});
                  },
                  //items: deckOfCardsExercises()
                  items: exerciseListHere

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
                    setState(() {});
                  },
                  //items: deckOfCardsExercises()
                  items: exerciseListHere

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
                    exercise4 = newValue!;
                    updateValues();
                    setState(() {});
                  },
                  //items: deckOfCardsExercises()
                  items: exerciseListHere
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
                          new RaisedButton(
                            key: null,
                            //onPressed: randomiseExercises,
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
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DeckOfCards(),
        )).then((value) => setState(() {}
    ));
  }


  void initState(){
    print("init");
    getExerciseList();
  }

  void getExerciseList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 0;

    do {
      if (prefs.getString("isSelected" + i.toString()) == "1" && deckOfCards[i]) {
        exerciseListHere.add(exerciseNamePlural[i]);
      }
      i++;
    } while (i < numberOfExercisesToChooseFrom);
    numberOfExercises = exerciseListHere.length;
    randomiseExercises();

    //exercise1 = exerciseListHere[0];
    //exercise2 = exerciseListHere[1];
    //exercise3 = exerciseListHere[2];
    //exercise4 = exerciseListHere[3];

    setState(() {

    });
  }

  void updateValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deckOfCardsExercise1', exercise1);
    prefs.setString('deckOfCardsExercise2', exercise2);
    prefs.setString('deckOfCardsExercise3', exercise3);
    prefs.setString('deckOfCardsExercise4', exercise4);
    setState(() {

    });
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
              setState(() {
              });
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

    exercise1 = exerciseListHere[ex[0]];
    exercise2 = exerciseListHere[ex[1]];
    exercise3 = exerciseListHere[ex[2]];
    exercise4 = exerciseListHere[ex[3]];

    updateValues();
    setState(() {});

  }

  void dispose() {
    // COMPLETE: Dispose an InterstitialAd object
    _interstitialAd?.dispose();

    super.dispose();
  }
}
