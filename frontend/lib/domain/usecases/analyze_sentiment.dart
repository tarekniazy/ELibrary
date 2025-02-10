import 'package:e_library/domain/repositories/book_repository.dart';

class AnalyzeSentiment {
  final BookRepository repository;

  AnalyzeSentiment(this.repository);

  Future<String> execute(String text) async {
    return await repository.analyzeSentiment(text);
  }
}