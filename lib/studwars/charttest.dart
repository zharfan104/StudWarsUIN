import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartMenangKalah extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChartMenangKalahState();
}

class ChartMenangKalahState extends State {
  List<PieChartSectionData> pieChartRawSections;
  List<PieChartSectionData> showingSections;

  StreamController<PieTouchResponse> pieTouchedResultStreamController;

  int touchedIndex;

  @override
  void initState() {
    super.initState();

    final menang = PieChartSectionData(
      color: Color(0xff0293ee),
      value: 10,
      title: "40%",
      radius: 30,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    );

    final kalah = PieChartSectionData(
      color: Color(0xfff8b250),
      value: 20,
      title: "30%",
      radius: 30,
      titleStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    );

    final items = [
      menang,
      kalah,
    ];

    pieChartRawSections = items;

    showingSections = pieChartRawSections;

    pieTouchedResultStreamController = StreamController();
    pieTouchedResultStreamController.stream.distinct().listen((details) {
      if (details == null) {
        return;
      }

      touchedIndex = -1;
      if (details.sectionData != null) {
        touchedIndex = showingSections.indexOf(details.sectionData);
      }

      setState(() {
        if (details.touchInput is FlLongPressEnd) {
          touchedIndex = -1;
          showingSections = List.of(pieChartRawSections);
        } else {
          showingSections = List.of(pieChartRawSections);

          if (touchedIndex != -1) {
            final TextStyle style = showingSections[touchedIndex].titleStyle;
            showingSections[touchedIndex] =
                showingSections[touchedIndex].copyWith(
              titleStyle: style.copyWith(
                fontSize: 24,
              ),
              radius: 40,
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlChart(
      chart: PieChart(
        PieChartData(
            pieTouchData: PieTouchData(
                touchResponseStreamSink: pieTouchedResultStreamController.sink),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 4,
            sections: showingSections),
      ),
    );
  }
}
