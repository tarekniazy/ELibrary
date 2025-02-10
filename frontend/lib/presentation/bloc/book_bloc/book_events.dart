// Events
import 'package:e_library/domain/entities/book.dart';
import 'package:e_library/domain/entities/saved_book.dart';

abstract class BookEvent {}

class FetchBookEvent extends BookEvent {
  final String bookId;
  FetchBookEvent(this.bookId);
}

class SaveBookEvent extends BookEvent {
  final String gutenbergId;
  final String title;
  final String language;
  final String content;
  final String textAnalysis;
  
  SaveBookEvent({
    required this.gutenbergId,
    required this.title,
    required this.language,
    required this.content,
    required this.textAnalysis
  });
}

class GetSavedBookEvent extends BookEvent {
  final Book book;
  GetSavedBookEvent(this.book);
}

class AnalyzeSentimentEvent extends BookEvent {
  final String text;
  final Book book;
  AnalyzeSentimentEvent(this.text, this.book);
}