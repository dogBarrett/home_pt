import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
    // if (!_isInterstitialAdReady) {
    //   _loadInterstitialAd();
    // }

    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          elevation: 0.0,
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
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body: new Container(
          height: 1.sh,
          width: 1.sw,
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    bottom: 0.01.sh,
                  ),
                  child: Text(
                    "Exercise Selection",
                    style: GoogleFonts.merriweather(
                      fontSize: 25.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                new SizedBox(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new GestureDetector(
                            onTap: randomiseExercises,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 0.015.sh,
                                horizontal: 0.04.sw,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade900,
                                borderRadius: BorderRadius.circular(
                                  0.03.sw,
                                ),
                              ),
                              width: 0.3.sw,
                              child: Text(
                                "Randomise",
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: 0.038.sw,
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            )),
                        new GestureDetector(
                            onTap: continueButton,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 0.015.sh,
                                horizontal: 0.04.sw,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade900,
                                borderRadius: BorderRadius.circular(
                                  0.03.sw,
                                ),
                              ),
                              width: 0.3.sw,
                              child: new Text(
                                "Continue",
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: 0.038.sw,
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                ),
                              ),
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
        .then((value) {
      _loadInterstitialAd();
    });
  }

  @override
  void initState() {
    super.initState();
    // Loading interstitialad when initstate
    _loadInterstitialAd();
    getExerciseList();
    setState(() {});
  }

  @override
  void dispose() {
    // COMPLETE: Dispose an InterstitialAd object
    _interstitialAd?.dispose();

    super.dispose();
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
    print("Inside loading ad");
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

  Container getDropdownMenu(String exerciseNumber, int dropdownNumber) {
    String cardSuit = "";

    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0.03.sw,
          vertical: 0.00.sh,
        ),
        margin: EdgeInsets.only(top: 0.015.sh),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.03.sw),
          border: Border.all(
            width: 0.002.sw,
            color: Colors.blueGrey.shade900,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: exerciseNumber,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24.sp,
            elevation: 16,
            style: TextStyle(color: Colors.blueGrey.shade900),

            onChanged: (String? newValue) {
              exerciseNumber = newValue!;
              exercises[dropdownNumber - 1] = exerciseNumber;
              setState(() {});
            },
            //items: deckOfCardsExercises()
            items:
                exerciseListHere.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ));
  }
}
