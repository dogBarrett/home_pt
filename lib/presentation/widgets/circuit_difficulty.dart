import 'dart:async';
import 'dart:core';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';
import 'package:home_pt/helpers/ad_helper.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../globals.dart';
import 'circuit_session.dart';

class CircuitDifficulty extends StatefulWidget {
  CircuitDifficulty({Key? key}) : super(key: key);
  @override
  _CircuitDifficulty createState() => new _CircuitDifficulty();
}

class _CircuitDifficulty extends State<CircuitDifficulty> {

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: new Text(
          'Select Difficulty',
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

  Widget getElevatedButton(
      int thisNumber, String thisString, String thisImage) {
    return GestureDetector(
      // style: getButtonStyle(),
      onTap: () {
        startSession(thisNumber);
      },
      child: getButtonContainer(thisString, "assets/images/" + thisImage),
    );
  }

  void initState() {

    super.initState();

  }

  Container getButtonContainer(String textLine, String imageAsset) {
    return Container(
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
          singleLineTextContainer(textLine, 0.04.sw),
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
          side: BorderSide(color: Colors.blueGrey, width: 2.0),
        ),
      ),
    );
  }

  void dispose() {
    // COMPLETE: Dispose an InterstitialAd object
    interstitialAd?.dispose();

    super.dispose();
  }

  void startSession(int levelNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("circuitDifficulty", levelNumber);
    showAd();
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
        style: GoogleFonts.merriweather(
          fontSize: 16.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
