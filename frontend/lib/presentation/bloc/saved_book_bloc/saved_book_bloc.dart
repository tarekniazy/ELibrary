import 'package:e_library/domain/usecases/get_books.dart';
import 'package:e_library/presentation/bloc/saved_book_bloc/saved_book_event.dart';
import 'package:e_library/presentation/bloc/saved_book_bloc/saved_book_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedBooksBloc extends Bloc<SavedBooksEvent, SavedBooksState> {
  final GetBooks getBooks;

  SavedBooksBloc({required this.getBooks}) : super(SavedBooksInitial()) {
    on<LoadSavedBooksEvent>(_onFetchBooks);
  }

  Future<void> _onFetchBooks(LoadSavedBooksEvent event, Emitter<SavedBooksState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userId = prefs.getString('user_id');
    
    if (token == null || userId == null) {
      emit(SavedBooksError("Authentication details not found"));
      return;
    }
    
    emit(SavedBooksLoading());
    try {
      final books = await getBooks.execute(userId, token);
      emit(SavedBooksLoaded(books));
    } catch (e) {
      emit(SavedBooksError(e.toString()));
    }
  }
}
