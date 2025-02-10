import 'package:e_library/domain/entities/book.dart';
import 'package:e_library/presentation/bloc/book_bloc/book_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_library/presentation/bloc/book_bloc/book_bloc.dart';
import 'package:e_library/presentation/bloc/book_bloc/book_events.dart';

class BookForm extends StatefulWidget {
  const BookForm({Key? key}) : super(key: key);

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter Book ID',
              hintText: 'e.g. 1661',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                final bookId = _controller.text.trim();
                if (bookId.isNotEmpty) {
                  context.read<BookBloc>().add(FetchBookEvent(bookId));
                }
              },
              child: const Text('Fetch Book'),
            ),
          BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state is BookLoaded) {
                return IconButton(
                  icon: const Icon(Icons.bookmark_add),
                  onPressed: () {
                    context.read<BookBloc>().add(SaveBookEvent(
                      gutenbergId: state.book.gutenbergId,
                      title: state.book.title,
                      language: state.book.language,
                      content: state.book.content,
                      textAnalysis: state.book.textAnalysis
                    ));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Book saved to your library'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  tooltip: 'Save Book',
                );
              }
              return IconButton(
                  icon: const Icon(Icons.bookmark_add, color: Colors.grey),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nothing to be saved'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  tooltip: 'Save Book',
                );
            },
          ),
          BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state is BookLoaded) {
                return IconButton(
                  icon: const Icon(Icons.summarize),
                  onPressed: () {
                    context.read<BookBloc>().add(
                        AnalyzeSentimentEvent(state.book.content, state.book));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Book analyzed'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  tooltip: 'Analyze Sentiment',
                );
              }
              return IconButton(
                  icon: const Icon(Icons.summarize, color: Colors.grey),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nothing to be analyzed'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  tooltip: 'Analyze Sentiment',
                );
            },
          ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}