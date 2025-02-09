import 'package:e_library/domain/entities/saved_book.dart';
import 'package:e_library/domain/repositories/saved_book_repository.dart';

class SaveBook {
  final SavedBookRepository repository;

  SaveBook(this.repository);

  Future<void> execute(SavedBook book, String token) async {
    return await repository.saveBook(book,token);
  }
}
