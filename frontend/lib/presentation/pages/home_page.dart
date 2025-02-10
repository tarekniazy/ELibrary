import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_library/presentation/bloc/book_bloc/book_bloc.dart';
import 'package:e_library/presentation/bloc/book_bloc/book_events.dart';
import 'package:e_library/presentation/bloc/book_bloc/book_states.dart';
import 'package:e_library/presentation/widgets/app_drawer.dart';
import 'package:e_library/presentation/widgets/book_content.dart';
import 'package:e_library/presentation/widgets/book_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gutenberg Reader'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const BookForm(),
            Expanded(
              child: BlocBuilder<BookBloc, BookState>(
                builder: (context, state) {
                  if (state is BookLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BookLoaded) {
                    return BookContent(book: state.book);
                  } else if (state is BookError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Enter a book ID to start'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}