class HistoryModel {
  final int id;
  final String imagePath;
  final String prediction;
  final String timestamp;

  HistoryModel({
    required this.id,
    required this.imagePath,
    required this.prediction,
    required this.timestamp,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      imagePath: json['image'],
      prediction: json['prediction'],
      timestamp: json['timestamp'],
    );
  }
}
