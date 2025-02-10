import 'package:e_library/domain/entities/saved_book.dart';

class SavedBookModel extends SavedBook {
  SavedBookModel({
    required id,
    required userId,
    required gutenbergId,
    required content,
    required textAnalysis,
    required title,
    required language,
    required downloadDate,
  }) : super(
          id: id,
          userId: userId,
          gutenbergId: gutenbergId,
          content: content,
          textAnalysis: textAnalysis,
          title: title,
          language: language,
          downloadDate: downloadDate,
        );

  factory SavedBookModel.fromJson(Map<String, dynamic> json) {
    return SavedBookModel(
      id: json['id'],
      userId: json['userId'],
      gutenbergId: json['gutenbergId'],
      content: json['content'],
      textAnalysis: json['textAnalysis'],
      title: json['title'],
      language: json['language'],
      downloadDate: DateTime.parse(json['downloadDate']),
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'gutenbergId': gutenbergId,
    'content': content,
    'textAnalysis': textAnalysis,
    'title': title,
    'language': language,
    'downloadDate': downloadDate.toIso8601String(), // Convert to ISO 8601 string
  };

  factory SavedBookModel.fromEntity(SavedBook savedBook) => SavedBookModel(
    id: savedBook.id,
    userId: savedBook.userId,
    gutenbergId: savedBook.gutenbergId,
    content: savedBook.content,
    textAnalysis: savedBook.textAnalysis,
    title: savedBook.title,
    language: savedBook.language,
    downloadDate: savedBook.downloadDate,
  );
}