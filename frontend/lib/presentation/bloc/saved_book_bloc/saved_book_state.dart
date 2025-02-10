// State classes
import 'package:e_library/domain/entities/saved_book.dart';

abstract class SavedBooksState {}

class SavedBooksInitial extends SavedBooksState {}
class SavedBooksLoading extends SavedBooksState {}
class SavedBooksLoaded extends SavedBooksState {
  final List<SavedBook> savedBooks;
  SavedBooksLoaded(this.savedBooks);
}
class SavedBooksError extends SavedBooksState {
  final String message;
  SavedBooksError(this.message);
}