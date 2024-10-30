import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/earnings_model.dart';
import '../models/earnings_transcript.dart';

class ApiService {
  final String _baseUrl = 'https://api.api-ninjas.com/v1/earningscalendar';
  final String baseUrl = 'https://api.api-ninjas.com/v1/earningstranscript';
  /// Fetch earnings data for the specified ticker
  Future<List<EarningsModel>> fetchEarnings(String ticker) async {
    final response = await http.get(Uri.parse('$_baseUrl?ticker=$ticker'),
        headers: {
          'X-Api-Key': '4Ay3uGrOyAJe7VdJm5XpmQ==P1JFMbdLMb1dJ7pO',
        });
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => EarningsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load earnings data');
    }
  }

  Future<EarningsTranscript?> fetchEarningsTranscript(String ticker, int year, int quarter) async {
    final response = await http.get(
      Uri.parse('$baseUrl?ticker=$ticker&year=$year&quarter=$quarter'),
      headers: {
        'X-Api-Key': '4Ay3uGrOyAJe7VdJm5XpmQ==P1JFMbdLMb1dJ7pO',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return EarningsTranscript.fromJson(data);
    } else {
      throw Exception('Failed to load earnings data');
    }
  }
}
