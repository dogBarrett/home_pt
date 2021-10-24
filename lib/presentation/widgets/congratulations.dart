import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:home_pt/presentation/widgets/main_menu.dart';

class Congratulations extends StatefulWidget {
  //DeckOfCardsPage({Key key}) : super(key: key);
  @override
  _Congratulations createState() => new _Congratulations();
}

class _Congratulations extends State<Congratulations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: InkWell(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/wellDone.jpg",
                fit: BoxFit.fill,
              ),
              Text(
                "Go to Home Screen",
                style: GoogleFonts.merriweather(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          )),
          onTap: () {
            buttonPressed();
          },
        ),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }

  void buttonPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MainMenu(),
      ),
    );
  }
}
