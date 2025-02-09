class SavedBook {
  final int id;
  final String userId;
  final int gutenbergId;
  final String title;
  final String language;
  final DateTime downloadDate;

  SavedBook({
    required this.id,
    required this.userId,
    required this.gutenbergId,
    required this.title,
    required this.language,
    required this.downloadDate,
  });
}