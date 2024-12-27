import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SummaryChart extends StatelessWidget {
  const SummaryChart({Key? key, required this.maxValue, required this.data1, required this.data2}) : super(key: key);

  final int maxValue;
  final List<FlSpot> data1;
  final List<FlSpot> data2;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: -500,
        maxY: maxValue.toDouble(),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((e) {
                return LineTooltipItem(
                  "${e.y.toStringAsFixed(0)}",
                  Theme.of(context).textTheme.bodyMedium ?? TextStyle(), // Ensure non-null TextStyle
                );
              }).toList();
            },
          ),
        ),
        gridData: buildFlGridData(),
        titlesData: buildFlTitlesData(context),
        lineBarsData: [
          buildLineChartBarData(
            data1,
            [Colors.tealAccent.withOpacity(0.5)],
          ),
          buildLineChartBarData(
            data2,
            [Colors.redAccent.withOpacity(0.5)],
          ),
        ],
      ),
    );
  }

  LineChartBarData buildLineChartBarData(List<FlSpot> data, List<Color> colors) {
    return LineChartBarData(
      belowBarData: BarAreaData(
        gradient: LinearGradient(
          colors: colors.map((color) => color.withOpacity(0.2)).toList(),
        ),
        show: true,
      ),
      isCurved: true,
      gradient: LinearGradient(
        colors: colors,
      ),
      dotData: FlDotData(show: false),
      spots: data,
    );
  }

  FlTitlesData buildFlTitlesData(BuildContext context) {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
          reservedSize: 22,
          getTitlesWidget: (value, meta) {
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
            return Container(
              margin: EdgeInsets.only(right: 8),
              child: Text(
                '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
            );
          },
        ),
      ),
    );
  }

  FlGridData buildFlGridData() {
    return FlGridData(
      drawHorizontalLine: true,
      drawVerticalLine: true,
      horizontalInterval: maxValue / 2,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.white10,
          strokeWidth: 0.5,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          dashArray: value == 0 ? null : [4],
          color: Colors.transparent,
          strokeWidth: 1,
        );
      },
    );
  }
}
