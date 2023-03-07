import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:home_pt/presentation/widgets/deck_of_cards_select_exercises.dart';

import '../../globals.dart';

class DeckOfCardsSettings extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _DeckOfCardsSettings createState() => new _DeckOfCardsSettings();
}

class _DeckOfCardsSettings extends State<DeckOfCardsSettings> {
  @override
  bool isAce1 = false;
  bool isAce11 = true;
  bool isPicture10 = false;
  bool isPicturePicture = true;

  Widget build(BuildContext context) {
    getBooleans();
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        title: new Text('Deck of Cards'),
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
              new Container(
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new ElevatedButton(
                          key: null,
                          onPressed: flipAce,
                          style:ElevatedButton.styleFrom(backgroundColor: Color(0xFFe0e0e0)),
                          //color: const Color(0xFFe0e0e0),
                          child: new Text(
                            "1 rep",
                            style: new TextStyle(
                                fontSize: 12.0,
                                color: const Color(0xFF000000),
                                fontWeight:
                                isAce1 ? FontWeight.w800 : FontWeight.w200,
                                fontFamily: "Roboto"),
                          )),
                      new Image.asset(
                        "assets/cards/AS.png",
                        fit: BoxFit.fill,
                      ),
                      new ElevatedButton(
                          key: null,
                          onPressed: flipAce,
                          style:ElevatedButton.styleFrom(backgroundColor: Color(0xFFe0e0e0)),
                          //color: const Color(0xFFe0e0e0),
                          child: new Text(
                            "11 reps",
                            style: new TextStyle(
                                fontSize: 12.0,
                                color: const Color(0xFF000000),
                                fontWeight:
                                isAce11 ? FontWeight.w800 : FontWeight.w200,
                                fontFamily: "Roboto"),
                          ))
                    ]),
                height: 100,
              ),
              new Container(
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new ElevatedButton(
                          key: null,
                          onPressed: flipPicture,
                          style:ElevatedButton.styleFrom(backgroundColor: Color(0xFFe0e0e0)),
                          //color: const Color(0xFFe0e0e0),
                          child: new Text(
                            "10 reps",
                            style: new TextStyle(
                                fontSize: 10.0,
                                color: const Color(0xFF000000),
                                fontWeight: isPicture10
                                    ? FontWeight.w800
                                    : FontWeight.w200,
                                fontFamily: "Roboto"),
                          )),
                      new Image.asset(
                        "assets/cards/KS.png",
                        fit: BoxFit.fill,
                      ),
                      new ElevatedButton(
                          key: null,
                          onPressed: flipPicture,
                          style:ElevatedButton.styleFrom(backgroundColor: Color(0xFFe0e0e0)),
                          //color: const Color(0xFFe0e0e0),
                          child: new Text(
                            "Card value",
                            style: new TextStyle(
                                fontSize: 10.0,
                                color: const Color(0xFF000000),
                                fontWeight: isPicturePicture
                                    ? FontWeight.w800
                                    : FontWeight.w200,
                                fontFamily: "Roboto"),
                          ))
                    ]),
                height: 100,
              ),
              new ElevatedButton(
                  key: null,
                  onPressed: proceed,
                  style:ElevatedButton.styleFrom(backgroundColor: Color(0xFFe0e0e0)),
                  //color: const Color(0xFFe0e0e0),
                  child: new Text(
                    "Continue",
                    style: new TextStyle(
                        fontSize: 12.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                  ))
            ]),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/light_background2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.center,
      ),
    );
  }

  void buttonPressed() {}

  void getBooleans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAce1 = prefs.getBool('boolAce1') ?? false;
    isAce11 = prefs.getBool('boolAce11') ?? true;
    isPicture10 = prefs.getBool('boolPicture10') ?? false;
    isPicturePicture = prefs.getBool('boolPicturePicture') ?? true;
  }

  void setBooleans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolAce1', isAce1);
    prefs.setBool('boolAce11', isAce11);
    prefs.setBool('boolPicture10', isPicture10);
    prefs.setBool('boolPicturePicture', isPicturePicture);
  }

  void flipAce() {
    if (isAce1) {
      isAce1 = false;
      isAce11 = true;
    } else {
      isAce1 = true;
      isAce11 = false;
    }
    setBooleans();
    setState(() {});
  }

  void flipPicture() {
    if (isPicture10) {
      isPicture10 = false;
      isPicturePicture = true;
    } else {
      isPicture10 = true;
      isPicturePicture = false;
    }
    setBooleans();
    setState(() {});
  }

  void proceed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeckOfCardsSelectExercises(),
      ),
    );
  }
}
