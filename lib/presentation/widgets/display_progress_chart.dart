import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_pt/presentation/widgets/display_daily_stats.dart';
import 'package:home_pt/presentation/widgets/progress_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../globals.dart';

class DisplayProgressChart extends StatefulWidget {
  @override
  _DisplayProgressChart createState() => _DisplayProgressChart();
}

class _DisplayProgressChart extends State<DisplayProgressChart> {
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Track My Stats'), actions: [
          IconButton(
            icon: Icon(
              Icons.pending_actions_sharp,
              //size: 9,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          Container(
            height: 0.4.sh,
            width: 0.9.sw,
            child: ProgressChart(
                data: globalDailyMeasurements,
                zoomPanBehavior: _zoomPanBehavior,
                topChart: true),
          ),
          Container(
            height: 0.4.sh,
            width: 0.9.sw,
            child: ProgressChart(
                data: globalDailyMeasurements,
                zoomPanBehavior: _zoomPanBehavior,
                topChart: false),
          ),
        ]));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        // Enables double tap zooming
        zoomMode: ZoomMode.x,
        enablePanning: true,
        enablePinching: true);

    super.initState();
  }
}
