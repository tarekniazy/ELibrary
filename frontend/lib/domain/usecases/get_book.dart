import '../entities/book.dart';
import '../repositories/book_repository.dart';

class GetBook {
  final BookRepository repository;

  GetBook(this.repository);

  Future<Book> execute(String bookId) async {
    return await repository.getBook(bookId);
  }
}