import 'package:e_library/data/datasources/saved_book_remote_data_source.dart';
import 'package:e_library/data/models/saved_book_model.dart';
import 'package:e_library/domain/entities/saved_book.dart';
import 'package:e_library/domain/repositories/saved_book_repository.dart';

class SavedBookRepositoryImpl implements SavedBookRepository {
  final SavedBookRemoteDataSource remoteDataSource;

  SavedBookRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> saveBook(SavedBook book, String token) async => await remoteDataSource.saveBook(SavedBookModel.fromEntity(book), token);

  @override
  Future<List<SavedBook>> getBooks(String userId, String token) async => await remoteDataSource.getSavedBooks(userId,token);

  @override
  Future<void> deleteBook(int id) async => await remoteDataSource.deleteBook(id);
}