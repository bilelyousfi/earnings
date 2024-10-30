import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../helper/date_helper.dart';
import '../helper/global.dart';
import '../models/earnings_model.dart';
class LineChartWidget extends StatelessWidget {
  final List<FlSpot> spots1;
  final List<FlSpot> spots2;
  final List<EarningsModel> earningsData; // Add this line
  final Function(String, int, int) onNodeTap;

  const LineChartWidget({
    Key? key,
    required this.spots1,
    required this.spots2,
    required this.earningsData, // Add this line
    required this.onNodeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Collect unique quarters with data points
    final displayedQuarters = <int>{};

    for (var spot in spots1) {
      displayedQuarters.add(spot.x.toInt());
    }
    for (var spot in spots2) {
      displayedQuarters.add(spot.x.toInt());
    }

    // Calculate min and max for X and Y axes
    double minX = displayedQuarters.reduce((a, b) => a < b ? a : b).toDouble();
    double maxX = displayedQuarters.reduce((a, b) => a > b ? a : b).toDouble();
    double minY = ([
      ...spots1.map((spot) => spot.y),
      ...spots2.map((spot) => spot.y),
    ]).reduce((a, b) => a < b ? a : b).toDouble();

    double maxY = ([
      ...spots1.map((spot) => spot.y),
      ...spots2.map((spot) => spot.y),
    ]).reduce((a, b) => a > b ? a : b).toDouble() + 1;

    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value % 1 == 0) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int quarter = value.toInt();
                  if (displayedQuarters.contains(quarter)) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Q$quarter',
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            lineChartBarData(spots1, AppColors.contentColorGreen),
            lineChartBarData(spots2, AppColors.contentColorPink),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              //tooltipBgColor: Colors.blueAccent,
            ),
            touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
              if (event is FlTapUpEvent && response != null) {
                final touchedSpot = response.lineBarSpots;
                if (touchedSpot != null && touchedSpot.isNotEmpty) {
                  final quarter = touchedSpot.first.x.toInt();
                  final earningsIndex = touchedSpot.first.barIndex; // Get the index of the tapped bar
                  final earnings = earningsData[earningsIndex];
                  final year = getYear(earnings.getParsedPriceDate());
                  final ticker = earnings.ticker; // Get the ticker from the earnings data

                  // Call the function to fetch earnings transcript
                  onNodeTap(ticker, year, quarter);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  LineChartBarData lineChartBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      isCurved: true,
      color: color.withOpacity(0.3),
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true), // Show dots for better visibility
      belowBarData: BarAreaData(show: false),
      spots: spots,
    );
  }
}

