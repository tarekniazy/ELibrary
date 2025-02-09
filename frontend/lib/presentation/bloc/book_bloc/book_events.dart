// Events
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
  
  SaveBookEvent({
    required this.gutenbergId,
    required this.title,
    required this.language,
  });
}