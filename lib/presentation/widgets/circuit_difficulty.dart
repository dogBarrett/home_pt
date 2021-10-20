import 'dart:async';
import 'dart:core';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';
import 'package:home_pt/helpers/ad_helper.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'circuit_session.dart';

class CircuitDifficulty extends StatefulWidget {
  CircuitDifficulty({Key? key}) : super(key: key);
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
            getElevatedButton(1, "Beginner (e.g. 2 burpees)", "bronze.png"),
            getElevatedButton(2, "Easy (e.g. 5 burpees)", "silver.png"),
            getElevatedButton(3, "Medium (e.g. 10 burpees)", "gold.png"),
            getElevatedButton(4, "Hard (e.g. 20 burpees)", "trophy_star.png"),
            getElevatedButton(
                5, "Insane (e.g. 25 burpees)", "trophy_normal.png"),
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

  ElevatedButton getElevatedButton(
      int thisNumber, String thisString, String thisImage) {
    return ElevatedButton(
      style: getButtonStyle(),
      onPressed: () {
        startSession(thisNumber);
      },
      child: getButtonContainer(thisString, "assets/images/" + thisImage),
    );
  }

  void initState() {
    // TODO: Load an Interstitial Ad
    if (!_isInterstitialAdReady) {
      _loadInterstitialAd();
    }
    super.initState();
    //_initGoogleMobileAds();
    //setState(() {

    //});
  }

  Container getButtonContainer(String textLine, String imageAsset) {
    return Container(
      height: 0.1.sh,
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
            fontSize: textSize.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: "Roboto"),
      ),
    );
  }
}
