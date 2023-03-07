import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:home_pt/globals.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressChart extends StatelessWidget {
  final List<DailyMeasurements> data;
  final ZoomPanBehavior zoomPanBehavior;
  final bool topChart;

  ProgressChart(
      {required this.data,
      required this.zoomPanBehavior,
      required this.topChart});

  final averageWeight =
      globalDailyMeasurements.map((d) => d.thisWeight).reduce((a, b) => a + b) /
          globalDailyMeasurements.length;

  List<DailyMeasurements> averageData = [];

  Widget build(BuildContext context) {
    //getAxisRange();
    getAverageWeight();
    return SfCartesianChart(
      title: getChartTitle(),
      zoomPanBehavior: zoomPanBehavior,
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.additional,
      ),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        getColumnSeries(),
        getLineSeries(),
      ],
    );
  }

  ColumnSeries getColumnSeries() {
    if (topChart) {
      return ColumnSeries<DailyMeasurements, String>(
        dataSource: data,
        xValueMapper: (DailyMeasurements d, _) => d.thisDate,
        yValueMapper: (DailyMeasurements d, _) => d.thisWeight,
        name: 'Weight',
      );
    } else {
      return ColumnSeries<DailyMeasurements, String>(
        dataSource: data,
        xValueMapper: (DailyMeasurements d, _) => d.thisDate,
        yValueMapper: (DailyMeasurements d, _) => d.thisFatPercent,
        name: 'Fat Percentage',
      );
    }
  }

  ChartTitle getChartTitle() {
    if (topChart) {
      return ChartTitle(
          text: 'Weight',
          alignment: ChartAlignment.center,
          textStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 14,
          ));
    } else {
      return ChartTitle(
          text: 'Body Fat %',
          alignment: ChartAlignment.center,
          textStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 14,
          ));
    }
  }

  LineSeries getLineSeries() {
    if (topChart) {
      return LineSeries<DailyMeasurements, String>(
        dataSource: averageData,
        xValueMapper: (DailyMeasurements d, _) => d.thisDate,
        yValueMapper: (DailyMeasurements d, _) => d.thisWeight,
        //name: 'Fat Percentage',
      );
    } else {
      return LineSeries<DailyMeasurements, String>(
        dataSource: averageData,
        xValueMapper: (DailyMeasurements d, _) => d.thisDate,
        yValueMapper: (DailyMeasurements d, _) => d.thisFatPercent,
        //name: 'Fat Percentage',
      );
    }
  }

  void getAverageWeight() {
    for (int i = 0; i < globalDailyMeasurements.length; i++) {
      double thisWeightSum = 0;
      double thisFatPercentSum = 0;
      for (int j = 0; j <= i; j++) {
        thisWeightSum = thisWeightSum + globalDailyMeasurements[j].thisWeight;
        thisFatPercentSum =
            thisFatPercentSum + globalDailyMeasurements[j].thisFatPercent;
      }
      double finalAvgeWeight = 0;
      double finalAvgeFatPercent = 0;

      if (i == 0) {
        finalAvgeWeight = globalDailyMeasurements[i].thisWeight;
        finalAvgeFatPercent = globalDailyMeasurements[i].thisFatPercent;
      } else {
        finalAvgeWeight = thisWeightSum / (i + 1);
        finalAvgeFatPercent = thisFatPercentSum / (i + 1);
      }
      averageData.add(DailyMeasurements(
          thisDate: globalDailyMeasurements[i].thisDate,
          thisWeight: finalAvgeWeight,
          thisFatPercent: finalAvgeFatPercent));
      print(averageData);
      print(thisWeightSum);
      print(
          averageData[i].thisDate + " " + averageData[i].thisWeight.toString());
    }
  }
}

class MyAverageData {
  late final String date;
  late final double avgeWeight;

  MyAverageData({
    required this.date,
    required this.avgeWeight,
  });
}
