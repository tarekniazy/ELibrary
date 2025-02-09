import 'package:e_library/domain/repositories/saved_book_repository.dart';

class DeleteBook {
  final SavedBookRepository repository;

  DeleteBook(this.repository);

  Future<void> execute(int id) async {
    await repository.deleteBook(id);
  }
}
