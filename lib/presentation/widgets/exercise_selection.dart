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
  @override
  List<bool> isSelected = List.filled(numberOfExercisesToChooseFrom, true);

  int imageViewing = 1;
  String currentExerciseImageAsset = "";

  Widget build(BuildContext context) {
    return new Scaffold(
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
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/light_background2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            itemCount: numberOfExercisesToChooseFrom,
            itemBuilder: (context, index) {
              return SwitchListTile(
                  secondary: InkWell(
                    onTap: () {
                      imageViewing = 1;
                      openExercise(index);
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
                        exerciseNamePlural[index],
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: "Roboto",
                        ),
                      )),
                  value: isSelected[index],
                  activeColor: Colors.blueGrey.shade900,
                  onChanged: (bool value) {
                    isSelected[index] = value;
                    //setPreferences();
                    setState(() {});
                  });
            },
          )),
    );
  }

  void initState() {
    super.initState();
    getPreferences();
    setState(() {});
  }

  void setPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 0;

    do {
      if (isSelected[i]) {
        prefs.setString("isSelected" + i.toString(), "1");
      } else {
        prefs.setString("isSelected" + i.toString(), "0");
      }
      i++;
    } while (i < numberOfExercisesToChooseFrom);
  }

  void getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 0;

    do {
      if (prefs.getString("isSelected" + i.toString()) == "1") {
        isSelected[i] = true;
      } else if (prefs.getString("isSelected" + i.toString()) == "0") {
        isSelected[i] = false;
      }
      i++;
    } while (i < numberOfExercisesToChooseFrom);
    setState(() {});
  }

  Future<void> openExercise(index) async {
    currentExerciseImageAsset = "assets/exercises/" +
        exerciseImageText[index] +
        imageViewing.toString() +
        ".png";
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
                              child: new Image.asset(
                                currentExerciseImageAsset,
                                fit: BoxFit.fitWidth,
                              ),
                              // height: MediaQuery.of(context).size.height * 0.5,
                            ),
                            onTap: () {
                              imageViewing++;
                              if (imageViewing <=
                                  numberOfExerciseImages[index]) {
                              } else {
                                imageViewing = 1;
                              }

                              currentExerciseImageAsset = "assets/exercises/" +
                                  exerciseImageText[index] +
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
                              child: Text(
                                "( Tap on the Image to show continuation )",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          new Container(
                            width: 1.sw,
                            color: Colors.white,
                            child: new Text(
                              description[index],
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
}
