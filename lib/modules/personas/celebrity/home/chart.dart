import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glok/data/models/stats_model.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  const Chart({super.key, required this.stats});
  final GlockerStatsModel stats;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      mainData(),
    );
  }

  List<String> days = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: MetaColors.tertiaryText,
      fontSize: 12,
    );
    String text = '';

    text = days[value.toInt()];
    // if (widget.stats.stat
    //         ?.firstWhereOrNull((element) => element.date?.weekday == value) !=
    //     null)
    return Text(
      text,
      style: style,
    );

    // return Text('');
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: MetaColors.secondaryText,
      fontSize: 12,
    );
    String text;

    text = '${value.toInt()}';
    if (widget.stats.stat
            ?.firstWhereOrNull((element) => element.amount == value) !=
        null) return Text(text, style: style, textAlign: TextAlign.left);
    return Text('');
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBorder: BorderSide(color: MetaColors.dividerColor),
          fitInsideHorizontally: true,
          tooltipRoundedRadius: 50,
          fitInsideVertically: true,
          tooltipBgColor: Colors.white,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;

              return LineTooltipItem(
                '${'\u20b9 ' + flSpot.y.toString()}',
                TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: MetaColors.dividerColor.withOpacity(0.4),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 22,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: 1,
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(bottom: BorderSide(color: MetaColors.dividerColor)),
      ),
      minX: widget.stats.stat?.isNotEmpty ?? false ? getMinX() : 0.0,
      maxX: widget.stats.stat?.isNotEmpty ?? false ? getMaxX() : 0.0,
      minY: 0,
      maxY: widget.stats.stat?.isNotEmpty ?? false ? getMaxY() : 0.0,
      baselineX: 0,
      baselineY: 0,
      lineBarsData: [
        LineChartBarData(
          color: Colors.orange,
          spots: getPoints(),
          isCurved: true,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }

  List<FlSpot> getPoints() {
    List<FlSpot> data = (widget.stats.stat ?? [])
        .map((e) => FlSpot(e.date!.weekday.toDouble(), e.amount!.toDouble()))
        .toList();
    return data;
  }

  double getMaxX() {
    return 6;
  }

  double getMinX() {
    return 0;
  }

  double getMaxY() {
    Stat? model;
    widget.stats.stat!.forEach((element) {
      if (model == null) {
        model = element;
      }
      if (element.amount! >= (model?.amount ?? 0)) {
        model = element;
      }
    });
    return model?.amount ?? 0;
  }

  double getMinY() {
    Stat? model;
    widget.stats.stat!.forEach((element) {
      if (model == null) {
        model = element;
      }
      if (element.amount! <= (model?.amount ?? 0)) {
        model = element;
      }
    });
    return model?.amount ?? 0;
  }
}
