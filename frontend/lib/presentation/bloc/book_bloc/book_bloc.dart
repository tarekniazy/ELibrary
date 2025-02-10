import 'package:e_library/domain/entities/book.dart';
import 'package:e_library/domain/entities/saved_book.dart';
import 'package:e_library/domain/usecases/analyze_sentiment.dart';
import 'package:e_library/domain/usecases/save_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_library/domain/usecases/get_book.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'book_events.dart';
import 'book_states.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBook getBook;
  final SaveBook saveBook;
  final AnalyzeSentiment analyzeSentiment;
  final FlutterSecureStorage storage;


  BookBloc({
    required this.getBook,
    required this.saveBook,
    required this.analyzeSentiment,
    required this.storage
  }) : super(BookInitial()) {
    on<FetchBookEvent>(_onFetchBook);
    on<SaveBookEvent>(_onSaveBook);
    on<GetSavedBookEvent>(_onGetSavedBook); // Add this line to handle the event>
    on<AnalyzeSentimentEvent>(_onAnalyzeSentiment);
  }

  Future<void> _onFetchBook(FetchBookEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    try {
      final book = await getBook.execute(event.bookId);
      emit(BookLoaded(book));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

    Future<void> _onAnalyzeSentiment(AnalyzeSentimentEvent event, Emitter<BookState> emit) async {
    emit(SentimentAnalysisLoading());
    try {
      final analysis =await analyzeSentiment.execute(event.text);
      
      emit(TextAnalysisLoaded(
        Book(
          gutenbergId: event.book.gutenbergId,
          title: event.book.title,
          language: event.book.language,
          content: event.book.content,
          textAnalysis: analysis,
          metadata: '',
        )
      ));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }

    void _onGetSavedBook(GetSavedBookEvent event, Emitter<BookState> emit) async {
    emit(BookLoaded(event.book));
  }

  Future<void> _onSaveBook(SaveBookEvent event, Emitter<BookState> emit) async {
    emit(BookSaving());
    try {
      final token = await storage.read(key: 'auth_token');
      final userId = await storage.read(key: 'user_id');
      
      if (token == null || userId == null) {
        throw Exception('Authentication required');
      }

      final savedBook = SavedBook(
        id: 0, // This will be set by the backend
        userId: userId,
        gutenbergId: event.gutenbergId,
        title: event.title,
        language: event.language,
        downloadDate: DateTime.now(),
        content: event.content,
        textAnalysis: event.textAnalysis
      );

      await saveBook.execute(savedBook, token);
      emit(BookSaved(Book(
        gutenbergId: event.gutenbergId,
        title: event.title,
        language: event.language,
        content: event.content,
        textAnalysis: event.textAnalysis,
        metadata: '',
          )));
    } catch (e) {
      emit(BookSaveError(e.toString()));
    }
  }
}