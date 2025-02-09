import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_library/domain/usecases/get_book.dart';

import 'book_events.dart';
import 'book_states.dart';



class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBook getBook;

  BookBloc({required this.getBook}) : super(BookInitial()) {
    on<FetchBookEvent>(_onFetchBook);
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
}