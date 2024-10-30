class EarningsModel {
  final String priceDate;
  final String ticker;
  final double actualEps;
  final double estimatedEps;
  final double actualRevenue;
  final double estimatedRevenue;

  EarningsModel({
    required this.priceDate,
    required this.ticker,
    required this.actualEps,
    required this.estimatedEps,
    required this.actualRevenue,
    required this.estimatedRevenue,
  });

  factory EarningsModel.fromJson(Map<String, dynamic> json) {
    return EarningsModel(
      priceDate: json['pricedate'] as String? ?? '', // Default to empty string if null
      ticker: json['ticker'] as String? ?? '', // Default to empty string if null
      actualEps: (json['actual_eps'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
      estimatedEps: (json['estimated_eps'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
      actualRevenue: (json['actual_revenue'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
      estimatedRevenue: (json['estimated_revenue'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
    );
  }

  // Convert priceDate string to DateTime
  DateTime getParsedPriceDate() {
    return DateTime.parse(priceDate); // Convert the string to DateTime
  }
}
