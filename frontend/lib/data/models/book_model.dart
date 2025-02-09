import '../../domain/entities/book.dart';

class BookModel extends Book {
  BookModel({
    required String content,
    required String metadata,
    required String title,
    required String language,
  }) : super(
          content: content,
          metadata: metadata,
          title: title,
          language: language,
        );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      content: json['content'],
      metadata: json['metadata'],
      title: json['title'],
      language: json['language'],
    );
  }
}