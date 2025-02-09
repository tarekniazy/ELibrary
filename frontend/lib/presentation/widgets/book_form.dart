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
        ElevatedButton(
          onPressed: () {
            final bookId = _controller.text.trim();
            if (bookId.isNotEmpty) {
              context.read<BookBloc>().add(FetchBookEvent(bookId));
            }
          },
          child: const Text('Fetch Book'),
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