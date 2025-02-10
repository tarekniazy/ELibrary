import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_data_source.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Book> getBook(String bookId) async {
    return await remoteDataSource.getBook(bookId);
  }

  @override
  Future<String> analyzeSentiment(String text) {
    return remoteDataSource.analyzeSentiment(text);
  }
}