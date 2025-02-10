import 'package:e_library/domain/usecases/get_books.dart';
import 'package:e_library/domain/usecases/save_book.dart';
import 'package:e_library/presentation/bloc/saved_book_bloc/saved_book_event.dart';
import 'package:e_library/presentation/bloc/saved_book_bloc/saved_book_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SavedBooksBloc extends Bloc<SavedBooksEvent, SavedBooksState> {
  final GetBooks getBooks;
  final FlutterSecureStorage storage;

  SavedBooksBloc({required this.getBooks,required this.storage}) : super(SavedBooksInitial()){
        on<LoadSavedBooksEvent>(_onFetchBooks);
  }
  
    Future<void> _onFetchBooks(LoadSavedBooksEvent event, Emitter<SavedBooksState> emit) async {
      final token = await storage.read(key: 'auth_token');
      final userId = await storage.read(key: 'user_id');
    emit(SavedBooksLoading());
    try {
      final books = await getBooks.execute(userId!,token!);
      emit(SavedBooksLoaded(books));
    } catch (e) {
      emit(SavedBooksError(e.toString()));
    }
  }

}