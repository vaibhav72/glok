import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: MetaColors.tertiaryText,
      fontSize: 12,
    );
    Widget text = Text(
      DateFormat('EEE')
          .format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
      style: style,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: MetaColors.secondaryText,
      fontSize: 12,
    );
    String text;

    text = '${value.toInt()}';

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
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
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 22,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
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
      minX: 0,
      maxX: widget.stats.stat?.isNotEmpty ?? false
          ? widget.stats.stat!.last.date!.millisecondsSinceEpoch.toDouble()
          : 0.0,
      minY: 0,
      maxY: widget.stats.stat?.isNotEmpty ?? false
          ? widget.stats.stat!.last.amount!.toDouble()
          : 0.0,
      lineBarsData: [
        LineChartBarData(
          color: Colors.orange,
          spots: (widget.stats.stat ?? [])
              .map((e) => FlSpot(e.date!.millisecondsSinceEpoch.toDouble(),
                  e.amount!.toDouble()))
              .toList(),
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
}
