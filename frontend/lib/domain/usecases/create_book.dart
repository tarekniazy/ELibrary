import 'package:e_library/domain/entities/saved_book.dart';
import 'package:e_library/domain/repositories/saved_book_repository.dart';

class CreateBook {
  final SavedBookRepository repository;

  CreateBook(this.repository);

  Future<SavedBook> execute(SavedBook book) async {
    return await repository.createBook(book);
  }
}
