import 'dart:async';
import 'dart:core';

import 'package:google_mobile_ads/google_mobile_ads.dart';


import 'package:flutter/material.dart';
import 'package:home_pt/helpers/ad_helper.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'circuit_session.dart';

class CircuitDifficulty extends StatefulWidget {
  //MainMenu({Key key}) : super(key: key);
  @override
  _CircuitDifficulty createState() => new _CircuitDifficulty();
}

class _CircuitDifficulty extends State<CircuitDifficulty> {
  @override
  bool isInitialised = false;

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  // TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        title: new Text('Circuit'),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: getButtonStyle(),
              onPressed: () {
                startSession(1);
              },
              child: getButtonContainer(
                  "Beginner (e.g. 2 burpees)", "assets/images/bronze.png"),
            ),
            ElevatedButton(
              style: getButtonStyle(),
              onPressed: () {
                startSession(2);
              },
              child: getButtonContainer(
                  "Easy (e.g. 5 burpees)", "assets/images/silver.png"),
            ),
            ElevatedButton(
              style: getButtonStyle(),
              onPressed: () {
                startSession(3);
              },
              child: getButtonContainer(
                  "Medium (e.g. 10 burpees)", "assets/images/gold.png"),
            ),
            ElevatedButton(
              style: getButtonStyle(),
              onPressed: () {
                startSession(4);
              },
              child: getButtonContainer(
                  "Hard (e.g. 20 burpees)", "assets/images/trophy_star.png"),
            ),
            ElevatedButton(
              style: getButtonStyle(),
              onPressed: () {
                startSession(5);
              },
              child: getButtonContainer("Insane (e.g. 25 burpees)",
                  "assets/images/trophy_normal.png"),
            ),
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/light_background2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.all(10.0),
      ),
    );
  }

  void initState() {
    // TODO: Load an Interstitial Ad
    if (!_isInterstitialAdReady) {
      _loadInterstitialAd();
    }
    //_initGoogleMobileAds();
    //setState(() {

    //});
  }

  Container getButtonContainer(String textLine, String imageAsset) {
    return Container(
      height: MediaQuery.of(context).size.height / 9,
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          singleLineTextContainer(textLine, 16.0),
          Image.asset(
            imageAsset,
            fit: BoxFit.fitHeight,
          ),
        ],
      ),
    );
  }

  ButtonStyle getButtonStyle() {
    return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.blueGrey, width: 2.0))));
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

  void dispose() {
    // COMPLETE: Dispose an InterstitialAd object
    _interstitialAd?.dispose();

    super.dispose();
  }

  void startSession(int levelNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("circuitDifficulty", levelNumber);

    // TODO: Display an Interstitial Ad
    if (_isInterstitialAdReady) {
      _interstitialAd?.show();
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CircuitSession(),
      ),
    );
  }

  Container singleLineTextContainer(String thisText, double textSize) {
    return Container(
      child: Text(
        thisText,
        style: new TextStyle(
            fontSize: textSize,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: "Roboto"),
      ),
    );
  }
}
