import '../entities/book.dart';

abstract class BookRepository {
  Future<Book> getBook(String bookId);
  Future<String> analyzeSentiment(String text);
}