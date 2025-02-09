// Events
abstract class BookEvent {}

class FetchBookEvent extends BookEvent {
  final String bookId;
  FetchBookEvent(this.bookId);
}