import 'package:e_library/domain/entities/saved_book.dart';

class SavedBookModel extends SavedBook {
  SavedBookModel({
    required id,
    required userId,
    required gutenbergId,
    required title,
    required language,
    required downloadDate,
  }) : super(
          id: id,
          userId: userId,
          gutenbergId: gutenbergId,
          title: title,
          language: language,
          downloadDate: downloadDate,
        );

  factory SavedBookModel.fromJson(Map<String, dynamic> json) {
    return SavedBookModel(
      id: json['id'],
      userId: json['userId'],
      gutenbergId: json['gutenbergId'],
      title: json['title'],
      language: json['language'],
      downloadDate: json['downloadDate'],
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'gutenbergId': gutenbergId,
    'title': title,
    'language': language,
    'downloadDate': downloadDate,
  };

  factory SavedBookModel.fromEntity(SavedBook savedBook) => SavedBookModel(
    id: savedBook.id,
    userId: savedBook.userId,
    gutenbergId: savedBook.gutenbergId,
    title: savedBook.title,
    language: savedBook.language,
    downloadDate: savedBook.downloadDate,
  );
}