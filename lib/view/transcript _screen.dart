import 'package:flutter/material.dart';
import '../models/earnings_transcript.dart';

class TranscriptScreen extends StatefulWidget {
  final EarningsTranscript earningsTranscript;

  const TranscriptScreen({super.key, required this.earningsTranscript});

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  @override
  Widget build(BuildContext context) {
    // Accessing the transcript text
    final transcriptText = widget.earningsTranscript.transcript; // Assuming transcript is a String property

    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings Transcript'), // Assuming ticker is a property
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color for the container
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, // Shadow color
                  offset: Offset(0, 2), // Shadow offset
                  blurRadius: 6, // Blur radius
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0), // Inner padding
            child: Text(
              transcriptText,
              style: const TextStyle(
                fontSize: 16, // Text size
                color: Colors.black, // Text color
                height: 1.5, // Line height for better readability
              ),
            ),
          ),
        ),
      ),
    );
  }
}
