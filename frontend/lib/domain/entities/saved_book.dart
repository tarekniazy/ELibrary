class SavedBook {
  final int id;
  final String userId;
  final String gutenbergId;
  final String content;
  final String textAnalysis;
  final String title;
  final String language;
  final DateTime downloadDate;

  SavedBook({
    required this.id,
    required this.userId,
    required this.gutenbergId,
    required this.content,
    required this.textAnalysis,
    required this.title,
    required this.language,
    required this.downloadDate,
  });
}