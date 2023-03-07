import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_pt/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:home_pt/helpers/ad_helper.dart';
import 'package:home_pt/helpers/getCard.dart';
import 'package:home_pt/presentation/widgets/deck_of_cards_select_exercises.dart';
import 'package:home_pt/presentation/widgets/sets_select_exercises2.dart';
import 'package:home_pt/presentation/widgets/sets_session.dart';
//import 'package:home_pt/presentation/widgets/sets_select_exercises.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals.dart';

class SetsSessionDifficulty extends StatefulWidget {
  //MainMenu({Key key}) : super(key: key);
  @override
  _SetsSessionDifficulty createState() => new _SetsSessionDifficulty();
}

class _SetsSessionDifficulty extends State<SetsSessionDifficulty> {
  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: new Text(
          'Sets Session',
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
                      'Beginner (e.g. 2 burpees)',
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
                      'Easy (e.g. 5 burpees)',
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
                      'Medium (e.g. 10 burpees)',
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
                      'Hard (e.g. 20 burpees)',
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
                startSession(5);
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
                      'Insane (e.g. 25 burpees)',
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

  initState() {
    super.initState();

  }

  void dispose() {
    // COMPLETE: Dispose an InterstitialAd object
    interstitialAd?.dispose();

    super.dispose();
  }

  void startSession(int levelNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("setsSessionDifficulty", levelNumber);

    showAd();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetsSession(),
      ),
    );
  }
}
