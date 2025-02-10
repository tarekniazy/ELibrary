// States
import 'package:e_library/domain/entities/book.dart';

abstract class BookState {}

class BookInitial extends BookState {}
class BookLoading extends BookState {}
class BookLoaded extends BookState {
  final Book book;
  BookLoaded(this.book);
}
class BookError extends BookState {
  final String message;
  BookError(this.message);
}

class BookSaving extends BookState {}

class BookSaved extends BookLoaded {
  BookSaved(Book book) : super(book);
}

class BookSaveError extends BookState {
  final String message;
  BookSaveError(this.message);
}

class TextAnalysisLoaded extends BookLoaded {
  TextAnalysisLoaded(Book book) : super(book);
}

class SentimentAnalysisLoading extends BookLoading {}