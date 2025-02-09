import 'package:e_library/domain/repositories/saved_book_repository.dart';

class GetBooks {
    final SavedBookRepository repository;

  GetBooks(this.repository);

  Future<void> execute(String userId) async {
    await repository.getBooks(userId);
  }
}