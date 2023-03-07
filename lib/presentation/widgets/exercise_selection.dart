import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_pt/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseSelection extends StatefulWidget {
  //SponsorsPage({Key key}) : super(key: key);
  @override
  _ExerciseSelection createState() => new _ExerciseSelection();
}

class _ExerciseSelection extends State<ExerciseSelection> {
  //List<bool> isSelected = List.filled(numberOfExercisesToChooseFrom, true);

  int imageViewing = 1;
  String currentExerciseImageAsset = "";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: Scaffold(
            appBar: new AppBar(
                backgroundColor: Colors.blueGrey.shade900,
                title: new Text(
                  'Select inclusions',
                  style: GoogleFonts.merriweather(
                    color: Colors.white,
                  ),
                ),
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 0.024.sh,
                  ),
                  onPressed: () {
                    setPreferences();
                    Navigator.of(context).pop();
                  },
                ),
                bottom: TabBar(isScrollable: true, tabs: [
                  getTabs("Chest"),
                  getTabs("Back"),
                  getTabs("Shoulders"),
                  getTabs("Legs"),
                  getTabs("Arms"),
                  getTabs("Core"),
                  getTabs("Full Body"),
                ])),
            body: TabBarView(children: <Widget>[
              getContainerList("chest"),
              getContainerList("back"),
              getContainerList("shoulders"),
              getContainerList("legs"),
              getContainerList("arms"),
              getContainerList("core"),
              getContainerList("fullBody"),

            ])));
  }

  Container getContainerList(String title) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/light_background2.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: getExerciseList(title),
    );
  }

  Tab getTabs(String title) {
    return Tab(
      child: Text(
        title,
        style: new TextStyle(
          fontSize: 0.035.sw,
          color: Colors.white,
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    getPreferences();
  }

  void setPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 0;

    do {
      if (exerciseList[i].isSelected) {
        prefs.setString("isSelected" + i.toString(), "1");
      } else {
        prefs.setString("isSelected" + i.toString(), "0");
      }

      i++;
    } while (i < newNumberOfExercisesToChooseFrom - 1);
  }

  void getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 0;

    do {
      if (prefs.getString("isSelected" + i.toString()) == "1") {
        exerciseList[i].isSelected = true;
      } else if (prefs.getString("isSelected" + i.toString()) == "0") {
        exerciseList[i].isSelected = false;
      }
      i++;
    } while (i < newNumberOfExercisesToChooseFrom - 1);

    exerciseList.sort((a, b) => a.exerciseName.compareTo(b.exerciseName));
    setState(() {});
  }

  Future<void> openExercise(index) async {
    currentExerciseImageAsset = "assets/exercises/" +
        exerciseList[index].exerciseImageText.toLowerCase() +
        imageViewing.toString() +
        ".png";
    print(currentExerciseImageAsset);
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 1.sw,
                child: new Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Container(
                              width: 1.sw,
                              child: Image.asset(
                                currentExerciseImageAsset,
                                fit: BoxFit.fitWidth,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    "assets/exercises/NoImageYet.jpeg",
                                    fit: BoxFit.fitWidth,
                                  );
                                },
                              ),
                            ),
                            onTap: () {
                              imageViewing++;
                              if (imageViewing <=
                                  exerciseList[index].numberOfExerciseImages) {
                              } else {
                                imageViewing = 1;
                              }

                              currentExerciseImageAsset = "assets/exercises/" +
                                  exerciseList[index].exerciseImageText.toLowerCase() +
                                  imageViewing.toString() +
                                  ".png";
                              setState(() {});
                            },
                          ),
                          Container(
                            width: 1.sw,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(0.035.sw),
                              child:
                              exerciseList[index].numberOfExerciseImages ==
                                  1
                                  ? null
                                  : Text(
                                "( Tap on the Image to show continuation )",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          new Container(
                            width: 1.sw,
                            color: Colors.white,
                            child: new Text(
                              exerciseList[index].description,
                              softWrap: true,
                              style: new TextStyle(
                                fontSize: 0.035.sw,
                                color: Colors.black87,
                              ),
                            ),
                            padding: EdgeInsets.all(0.035.sw),
                            alignment: Alignment.topCenter,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(
                            0.1.sw,
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          color: const Color(0xFF000000),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
              ),
            );
          },
        );
      },
    );
  }

  Container getExerciseList(String muscleGroup) {
    List<ExerciseAndIndex> thisExerciseList = [];

    switch (muscleGroup) {
      case "chest":
        thisExerciseList = chestExercises;
        break;
      case "back":
        thisExerciseList = backExercises;
        break;
      case "shoulders":
        thisExerciseList = shoulderExercises;
        break;
      case "legs":
        thisExerciseList = legsExercises;
        break;
      case "arms":
        thisExerciseList = armExercises;
        break;
      case "core":
        thisExerciseList = coreExercises;
        break;
      case "fullBody":
        thisExerciseList = fullBodyExercises;
        break;
    }
    return Container(
      child: ListView.builder(
        itemCount: thisExerciseList.length,
        itemBuilder: (context, index) {
          return SwitchListTile(
              secondary: InkWell(
                onTap: () {
                  imageViewing = 1;
                  openExercise(thisExerciseList[index].indexNumber);
                },
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.blueGrey.shade900,
                  size: 0.06.sw,
                ),
              ),
              title: Transform(
                  transform: Matrix4.translationValues(-0.05.sw, 0.0, 0.0),
                  child: Text(
                    thisExerciseList[index].exerciseName,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Roboto",
                    ),
                  )),
              value:
              exerciseList[thisExerciseList[index].indexNumber].isSelected,
              activeColor: Colors.blueGrey.shade900,
              onChanged: (bool value) {
                exerciseList[thisExerciseList[index].indexNumber].isSelected =
                    value;
                setState(() {});
              });
        },
      ),
    );
  }
}
