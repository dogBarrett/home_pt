import 'dart:async';
import 'dart:core';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:home_pt/helpers/ad_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart';
import 'hiit_session.dart';

class HIITDifficulty extends StatefulWidget {
  @override
  _HIITDifficulty createState() => new _HIITDifficulty();
}

class _HIITDifficulty extends State<HIITDifficulty> {

  InterstitialAd? _interstitialAd;
  int _countMaxAdFailedToLoad = 3;
  int _countAdInitialToLoad = 0;

  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: new Text(
          'HIIT',
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
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                startSession(0);
              },
              child: Container(
                height: 0.1.sh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.035.sw),
                  border: Border.all(color: Colors.blueGrey, width: 2.0),
                  color: Colors.transparent,
                ),
                padding: EdgeInsets.all(0.03.sw),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Beginner 10 on / 20 off x6',
                      style: GoogleFonts.merriweather(
                        fontSize: 16.sp,
                        color: Colors.black,
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
            GestureDetector(
              onTap: () {
                startSession(1);
              },
              child: Container(
                height: 0.1.sh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.035.sw),
                  border: Border.all(color: Colors.blueGrey, width: 2.0),
                  color: Colors.transparent,
                ),
                padding: EdgeInsets.all(0.03.sw),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Easy  10 on / 10 off x6',
                      style: GoogleFonts.merriweather(
                        fontSize: 16.sp,
                        color: Colors.black,
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
            GestureDetector(
              onTap: () {
                startSession(2);
              },
              child: Container(
                height: 0.1.sh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.035.sw),
                  border: Border.all(color: Colors.blueGrey, width: 2.0),
                  color: Colors.transparent,
                ),
                padding: EdgeInsets.all(0.03.sw),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Medium  20 on / 10 off x8',
                      style: GoogleFonts.merriweather(
                        fontSize: 16.sp,
                        color: Colors.black,
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
            GestureDetector(
              onTap: () {
                startSession(3);
              },
              child: Container(
                height: 0.1.sh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.035.sw),
                  border: Border.all(color: Colors.blueGrey, width: 2.0),
                  color: Colors.transparent,
                ),
                padding: EdgeInsets.all(0.03.sw),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Hard  20 on / 10 off x10',
                      style: GoogleFonts.merriweather(
                        fontSize: 16.sp,
                        color: Colors.black,
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
            GestureDetector(
              onTap: () {
                startSession(4);
              },
              child: Container(
                height: 0.1.sh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.035.sw),
                  border: Border.all(color: Colors.blueGrey, width: 2.0),
                  color: Colors.transparent,
                ),
                padding: EdgeInsets.all(0.03.sw),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Insane  20 on / 10 off x15',
                      style: GoogleFonts.merriweather(
                        fontSize: 16.sp,
                        color: Colors.black,
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

  void initState() {
    super.initState();

  }

  void dispose() {
    // COMPLETE: Dispose an InterstitialAd object
    _interstitialAd?.dispose();
    super.dispose();
  }

  void startSession(int levelNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("hiitDifficulty", levelNumber);

    showAd();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HIITSession(),
      ),
    );
  }

}
