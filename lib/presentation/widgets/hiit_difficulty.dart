import 'dart:async';
import 'dart:core';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:home_pt/helpers/ad_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hiit_session.dart';


class HIITDifficulty extends StatefulWidget {
  @override
  _HIITDifficulty createState() => new _HIITDifficulty();
}

class _HIITDifficulty extends State<HIITDifficulty> {
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
        title: new Text('HIIT'),
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
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side:
                              BorderSide(color: Colors.blueGrey, width: 2.0)))),
              onPressed: () {
                startSession(0);

              },
              child: Container(
                height: MediaQuery.of(context).size.height / 9,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Beginner 10 on / 20 off x6',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/images/bronze.png",
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
              onPressed: () {
                startSession(1);

              },
              child: Container(
                height: MediaQuery.of(context).size.height / 9,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Easy  10 on / 10 off x6',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/images/silver.png",
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
              onPressed: () {
                startSession(2);

              },
              child: Container(
                height: MediaQuery.of(context).size.height / 9,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Medium  20 on / 10 off x8',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/images/gold.png",
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
              onPressed: () {
                startSession(3);

              },
              child: Container(
                height: MediaQuery.of(context).size.height / 9,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Hard  20 on / 10 off x10',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/images/trophy_star.png",
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
              onPressed: () {
                startSession(4);

              },
              child: Container(
                height: MediaQuery.of(context).size.height / 9,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Insane  20 on / 10 off x15',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/images/trophy_normal.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
              ),
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

  initState(){
    // TODO: Load an Interstitial Ad
    if (!_isInterstitialAdReady) {
      _loadInterstitialAd();
    }
    //setState(() {

    //});
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

  void startSession(int levelNumber) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("hiitDifficulty", levelNumber);

    // TODO: Display an Interstitial Ad
    if (_isInterstitialAdReady) {
      _interstitialAd?.show();
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HIITSession(),
      ),
    );
  }
}
