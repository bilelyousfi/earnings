import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../models/earnings_model.dart';
import '../viewModel/earnings_view_model.dart';
import '../widget/line_chart_widget.dart';
import '../helper/date_helper.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    final earningsViewModel = Provider.of<EarningsViewModel>(context);
    final earningsList = earningsViewModel.earningsList;

    // Check if there are earnings to display
    if (earningsList.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Earnings Comparison'),
        ),
        body: const Center(child: Text('No earnings data available.')),
      );
    }

    // Generate spots data for actual and estimated earnings
    final actualEarningsData = _createChartData(earningsList, true);
    final estimatedEarningsData = _createChartData(earningsList, false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings Comparison'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, right: 10),
          child: Column(
            children: [
              // Show loading indicator if data is being fetched
              if (earningsViewModel.isLoading)
                const Center(child: CircularProgressIndicator()),

              // Your LineChartWidget
              LineChartWidget(
                spots1: actualEarningsData,
                spots2: estimatedEarningsData,
                earningsData: earningsList, // Pass the earnings data here
                onNodeTap: (ticker, year, quarter) {
                  // Call your fetchEarningsTranscript function here
                  Provider.of<EarningsViewModel>(context, listen: false)
                      .fetchEarningsTranscript(context, ticker, year, quarter);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Create chart data from earnings list
  List<FlSpot> _createChartData(List<EarningsModel> earningsList, bool isActual) {
    return List<FlSpot>.generate(earningsList.length, (index) {
      final earnings = earningsList[index];
      final yValue = isActual ? earnings.actualEps : earnings.estimatedEps;
      int quarter = getQuarter(earnings.getParsedPriceDate());
      return FlSpot(quarter.toDouble(), yValue);
    });
  }
}
