import 'package:earnings/helper/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:earnings/models/earnings_model.dart';
import 'package:earnings/services/api_service.dart';
import '../models/earnings_transcript.dart';
import '../view/graph_screen.dart';
import '../view/transcript _screen.dart';

class EarningsViewModel extends ChangeNotifier {
  List<EarningsModel> earningsList = [];
  final apiService = ApiService();
  bool isLoading = false;
  EarningsTranscript? earningsTranscript;

  Future<void> fetchEarningsTranscript(BuildContext context, String ticker, int year, int quarter) async {
    isLoading = true; // Set loading state to true
    notifyListeners(); // Notify listeners for the UI to reflect the loading state
    try {
      // Fetch the earnings transcript using the API service
      earningsTranscript = await apiService.fetchEarningsTranscript(ticker, year, quarter);
      if (earningsTranscript != null) {
        // Navigate to the TranscriptScreen with the fetched transcript
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TranscriptScreen(earningsTranscript: earningsTranscript!), // Pass the transcript to the TranscriptScreen
          ),
        );
      } else {
        // Handle case where no transcript was found
        MyDialog.info("No earnings transcript available. !!!!");
      }
    } catch (e) {
      MyDialog.error("Failed to load earnings transcript !!!!");

    } finally {
      isLoading = false; // Set loading state to false
      notifyListeners(); // Notify listeners to update the UI
    }
  }


  Future<void> fetchEarningsAndNavigate(BuildContext context, String ticker) async {
    if (ticker.isNotEmpty) {
      isLoading = true;
      notifyListeners();

      earningsList = await apiService.fetchEarnings(ticker);
      earningsList.sort((a, b) => a.priceDate.compareTo(b.priceDate));
      isLoading = false;
      notifyListeners();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GraphScreen(),
        ),
      );
    } else {
      MyDialog.info("Please enter a company ticker !!!!");

    }
  }

}
