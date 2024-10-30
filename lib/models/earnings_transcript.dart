
class EarningsTranscript {
  final String transcript;

  EarningsTranscript({required this.transcript});

  factory EarningsTranscript.fromJson(Map<String, dynamic> json) {
    return EarningsTranscript(
      transcript: json['transcript'] as String,
    );
  }
}
