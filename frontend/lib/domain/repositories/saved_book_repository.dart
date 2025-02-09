import 'package:e_library/domain/entities/saved_book.dart';

abstract class SavedBookRepository {
  Future<SavedBook> getBook(String bookId);
  Future<SavedBook> createBook(SavedBook book);
  Future<void> deleteBook(int id);
}