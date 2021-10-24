import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'main_menu.dart';
import 'package:home_pt/globals.dart' as globals;

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPage createState() => new _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  @override
  initState() {
    super.initState();
    Timer(const Duration(seconds: 5), onClose);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 0.4.sh,
                child: new Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fill,
                ),
              ),
            ]),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }

  void onClose() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MainMenu(),
      ),
    );
  }
}
