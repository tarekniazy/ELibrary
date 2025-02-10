import 'package:e_library/domain/entities/book.dart';
import 'package:e_library/presentation/bloc/book_bloc/book_bloc.dart';
import 'package:e_library/presentation/bloc/book_bloc/book_events.dart';
import 'package:e_library/presentation/bloc/book_bloc/book_states.dart';
import 'package:e_library/presentation/bloc/saved_book_bloc/saved_book_bloc.dart';
import 'package:e_library/presentation/bloc/saved_book_bloc/saved_book_event.dart';
import 'package:e_library/presentation/bloc/saved_book_bloc/saved_book_state.dart';
import 'package:e_library/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedBooksPage extends StatelessWidget {
  const SavedBooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: const Text('Saved Books'),
  ),
  body: BlocConsumer<SavedBooksBloc, SavedBooksState>(
    listener: (context, state) {
      if (state is SavedBooksError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    },
    builder: (context, state) {
      if (state is SavedBooksLoading) {
        return const Center(child: CircularProgressIndicator());
      } 
      
      if (state is SavedBooksLoaded) {
        return state.savedBooks.isEmpty
            ? const Center(child: Text('No saved books'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.savedBooks.length,
                itemBuilder: (context, index) {
                  final book = state.savedBooks[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        book.title,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text('Language: ${book.language}'),
                          Text('Downloaded: ${book.downloadDate}'),
                        ],
                      ),
                      onTap: () {
                        context.read<BookBloc>().add(
                          GetSavedBookEvent(
                            Book(
                              content: book.content,
                              gutenbergId: book.gutenbergId,
                              language: book.language,
                              textAnalysis: book.textAnalysis,
                              title: book.title,
                              metadata: ''
                            )
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
      }
      
      return const Center(child: Text('Load saved books'));
    },
  ),
);
  }
}