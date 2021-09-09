import 'dart:core';
import 'dart:math';
import 'package:home_pt/globals.dart' as globals;
import 'package:google_mobile_ads/google_mobile_ads.dart';


import 'package:flutter/material.dart';
import 'package:home_pt/helpers/ad_helper.dart';
import 'package:home_pt/helpers/getCard.dart';
import 'package:home_pt/presentation/widgets/congratulations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeckOfCards extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
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
  String ex1Plural = "";
  String ex2Plural = "";
  String ex3Plural = "";
  String ex4Plural = "";

  List<bool> hasBeenUsed = List.filled(52, false);

  var randomNumber = new Random();

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
    getPreferences();
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
              _getCardsLeftText(),
              new Container(
                height: 10,
              ),
              new InkWell(
                child: Container(
                  child: _getCardImage(),
                  height: MediaQuery.of(context).size.height * 0.6,
                ),
                onTap: () {
                  if(numberOfCardsLeft == 52){
                    // TODO: Display an Interstitial Ad
                    if (_isInterstitialAdReady) {
                      _interstitialAd?.show();

                      setState(() {
                        numberOfCardsLeft--;
                        currentCard = randomNumber.nextInt(52);
                      });
                    }
                  }
                  else if (numberOfCardsLeft > 1 && numberOfCardsLeft < 52) {
                    do {
                      currentCard = randomNumber.nextInt(52);
                    } while (hasBeenUsed[currentCard]);
                    numberOfCardsLeft--;
                    hasBeenUsed[currentCard] = true;

                    setState(() {});
                  }
                  else
                    finishDeckOfCards();
                },
              ),
              new Container(
                height: 10,
              ),
              _getExercisesLeft(),
            ]),
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.center,
      ),
    );
  }

  void finishDeckOfCards(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Congratulations(),
      ),
    );
  }

  void _moveToHome(){
    Navigator.of(context).pop;
  }
  Widget _getCardsLeftText() {
    return Text(
      numerousOrSingleCardLeft(),
      style: new TextStyle(
          fontSize: 24.0,
          color: const Color(0xFF000000),
          fontWeight: FontWeight.w200,
          fontFamily: "Roboto"),
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
                numberOfCardsLeft = 51;
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


  Widget _getCardImage() {
    return Image.asset(
      getCardImageText(currentCard),
      fit: BoxFit.contain,
    );
  }

  Widget _getExercisesLeft() {
    return Text(
      getTextForBottomText(),
      style: new TextStyle(
          fontSize: 24.0,
          color: const Color(0xFF000000),
          fontWeight: FontWeight.w200,
          fontFamily: "Roboto"),
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

  void dispose() {
    // COMPLETE: Dispose an InterstitialAd object
    _interstitialAd?.dispose();

    super.dispose();
  }

}
