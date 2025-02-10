import 'package:e_library/domain/entities/saved_book.dart';

abstract class SavedBookRepository {
  Future<List<SavedBook>> getBooks(String userId, String token);
  Future<void> saveBook(SavedBook book, String token);
  Future<void> deleteBook(int id);
}