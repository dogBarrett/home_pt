import 'dart:core';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'exercise_selection.dart';
import 'package:home_pt/globals.dart';

import 'weights_select_exercises.dart';

class WeightsSelectMuscleGroup extends StatefulWidget {
  WeightsSelectMuscleGroup({Key? key}) : super(key: key);
  @override
  _WeightsSelectMuscleGroup createState() => new _WeightsSelectMuscleGroup();
}

class _WeightsSelectMuscleGroup extends State<WeightsSelectMuscleGroup> {
  @override
  Widget build(BuildContext context) {
    var appBarHeight = AppBar().preferredSize.height;
    var paddingTop = MediaQuery.of(context).padding.top;

    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 0.024.sh,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExerciseSelection(),
                ),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: new Container(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 0.01.sh,
                  top: appBarHeight + paddingTop,
                ),
                child: Text(
                  "Select Muscle Group",
                  style: GoogleFonts.merriweather(
                    fontSize: 28.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  weightsChest = true;
                  weightsAbs = false;
                  weightsArms = false;
                  weightsLegs = false;
                  weightsBack = false;
                  weightsShoulders = false;
                  weightsBiceps = false;
                  weightsTriceps = false;

                  openSession();
                },
                child: getTile(0),

              ),
              GestureDetector(
                onTap: () {
                  weightsChest = false;
                  weightsAbs = false;
                  weightsArms = false;
                  weightsLegs = false;
                  weightsBack = false;
                  weightsShoulders = true;
                  weightsBiceps = false;
                  weightsTriceps = false;
                  openSession();
                },
                child: getTile(1),

              ),
              GestureDetector(
                onTap: () {
                  weightsChest = false;
                  weightsAbs = false;
                  weightsArms = false;
                  weightsLegs = false;
                  weightsBack = true;
                  weightsShoulders = false;
                  weightsBiceps = false;
                  weightsTriceps = false;
                  openSession();
                },
                child: getTile(2),
              ),
              GestureDetector(
                onTap: () {
                  weightsChest = false;
                  weightsAbs = false;
                  weightsArms = false;
                  weightsLegs = true;
                  weightsBack = false;
                  weightsShoulders = false;
                  weightsBiceps = false;
                  weightsTriceps = false;
                  openSession();
                },
                child: getTile(3),
              ),
              GestureDetector(
                onTap: () {
                  weightsChest = false;
                  weightsAbs = true;
                  weightsArms = false;
                  weightsLegs = false;
                  weightsBack = false;
                  weightsShoulders = false;
                  weightsBiceps = false;
                  weightsTriceps = false;
                  openSession();
                },
                child: getTile(4),
              ),
              GestureDetector(
                onTap: () {
                  weightsChest = false;
                  weightsAbs = false;
                  weightsArms = true;
                  weightsLegs = false;
                  weightsBack = false;
                  weightsShoulders = false;
                  weightsBiceps = false;
                  weightsTriceps = false;
                  openSession();
                },
                child: getTile(5),
              ),
              GestureDetector(
                onTap: () {
                  weightsChest = false;
                  weightsAbs = false;
                  weightsArms = false;
                  weightsLegs = false;
                  weightsBack = false;
                  weightsShoulders = false;
                  weightsBiceps = true;
                  weightsTriceps = false;
                  openSession();
                },
                child: getTile(6),
              ),
              GestureDetector(
                onTap: () {
                  weightsChest = false;
                  weightsAbs = false;
                  weightsArms = false;
                  weightsLegs = false;
                  weightsBack = false;
                  weightsShoulders = false;
                  weightsBiceps = false;
                  weightsTriceps = true;
                  openSession();
                },
                child: getTile(7),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/light_background2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.only(left: 0.02.sh, right: 0.02.sh),
      ),
    );
  }

  void openSession() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WeightsSelectExercises(),

      ),
    );
  }

  Container getTile(int thisNumber) {
    String imageFile = "";
    String thisTitle = "";
    String thisExplanation = "";

    if (thisNumber == 0){
      imageFile = "assets/images/exercise_chest.jpg";
      thisTitle = "Chest";
      thisExplanation = "Build those pecs";
    }
    else if(thisNumber == 1){
      imageFile = "assets/images/exercise_shoulders.jpg";
      thisTitle = "Shoulders";
      thisExplanation = "Shoulder exercises";
    }
    else if(thisNumber == 2){
      imageFile = "assets/images/exercise_back.jpg";
      thisTitle = "Back";
      thisExplanation = "Lat pull downs, rows, etc.";
    }
    else if(thisNumber == 3){
      imageFile = "assets/images/exercise_legs.jpg";
      thisTitle = "Legs";
      thisExplanation = "Squats, lunges, all the best leg exercises";
    }
    else if(thisNumber == 4){
      imageFile = "assets/images/exercise_abs.jpg";
      thisTitle = "Abs / Core";
      thisExplanation = "All exercises to work out abs and core";
    }
    else if(thisNumber == 5){
      imageFile = "assets/images/exercise_biceps.jpg";
      thisTitle = "Arms";
      thisExplanation = "A session the includes biceps and tricep exercises";
    }
    else if(thisNumber == 6){
      imageFile = "assets/images/exercise_bicep.jpg";
      thisTitle = "Biceps";
      thisExplanation = "A session the includes only biceps exercises";
    }
    else if(thisNumber == 7){
      imageFile = "assets/images/exercise_triceps.jpg";
      thisTitle = "Triceps";
      thisExplanation = "A session the includes only tricep exercises";
    }

    return Container(
      height: 0.3.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(0.05.sw),
      ),
      margin: EdgeInsets.only(bottom: 0.02.sh),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(0.05.sw),
            child: Container(
              height: 0.4.sh,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageFile),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.srcOver,
                  ),
                ),
              ),
              width: 1.sw,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              margin:
              EdgeInsets.only(left: 0.05.sw, top: 0.035.sh),
              child: Text(
                thisTitle,
                style: GoogleFonts.merriweather(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 0.8.sw,
              margin:
              EdgeInsets.only(left: 0.05.sw, bottom: 0.035.sh),
              child: Text(
                thisExplanation,
                style: TextStyle(
                  fontSize: 11.sp,
                  letterSpacing: 0.3,
                  wordSpacing: 1,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
