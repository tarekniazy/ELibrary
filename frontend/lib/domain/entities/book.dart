class Book {
  final String gutenbergId;
  final String content;
  final String textAnalysis;
  final String metadata;
  final String title;
  final String language;

  Book({
    required this.gutenbergId,
    required this.content,
    required this.textAnalysis,
    required this.metadata,
    required this.title,
    required this.language,
  });
}