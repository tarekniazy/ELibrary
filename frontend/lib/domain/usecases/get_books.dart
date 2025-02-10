import 'package:e_library/domain/entities/saved_book.dart';
import 'package:e_library/domain/repositories/saved_book_repository.dart';

class GetBooks {
    final SavedBookRepository repository;

  GetBooks(this.repository);

  Future<List<SavedBook>> execute(String userId, String token) async {
    return await repository.getBooks(userId,token);
  }
}