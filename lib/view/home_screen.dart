import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/earnings_view_model.dart';
import '../widget/input_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _tickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings Tracker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content
            children: [
              InputWidget(
                controller: _tickerController,
                onSubmit: _fetchEarnings,
              ),
              const SizedBox(height: 16),
              Consumer<EarningsViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return const CircularProgressIndicator(); // Show loading indicator
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchEarnings() {
    String ticker = _tickerController.text.trim();
    Provider.of<EarningsViewModel>(context, listen: false)
        .fetchEarningsAndNavigate(context, ticker);
    _tickerController.clear();
  }

  @override
  void dispose() {
    _tickerController.dispose();
    super.dispose();
  }
}
