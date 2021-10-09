import 'package:flutter/material.dart';
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
        backgroundColor: Colors.transparent,
        title: new Text('Select inclusions'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 16,
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
                    child: const Icon(Icons.help),
                  ),
                  title: Transform(
                      transform: Matrix4.translationValues(-24, 0.0, 0.0),
                      child: Text(
                        exerciseNamePlural[index],
                        style: TextStyle(fontSize: 18.sp),
                      )),
                  value: isSelected[index],
                  onChanged: (bool value) {
                    isSelected[index] = value;
                    //setPreferences();
                    setState(() {});
                  });
            },
          )),
    );
  }

  void initState(){
    super.initState();
    getPreferences();
    setState((){});

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
      }
      else if (prefs.getString("isSelected" + i.toString()) == "0") {
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
            return AlertDialog(
              content: Container(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.close),
                            color: const Color(0xFF000000),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      new InkWell(
                        child: Container(
                          child: new Image.asset(
                            currentExerciseImageAsset,
                            fit: BoxFit.contain,
                          ),
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        onTap: () {
                          imageViewing++;
                          if (imageViewing <= numberOfExerciseImages[index]) {
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

                      new Container(
                          child: SingleChildScrollView(
                            child: new Text(
                              description[index],
                              style: new TextStyle(
                                fontSize: 16.0, color: Colors.black87,
                              ),
                            ),
                          ),

                          padding: const EdgeInsets.all(0.0),
                          alignment: Alignment.topCenter,
                          height: MediaQuery.of(context).size.height * 0.4
                      )
                    ]),
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
