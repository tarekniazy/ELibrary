import 'package:e_library/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_library/presentation/bloc/saved_book_bloc/saved_book_bloc.dart';
import 'package:e_library/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/book_bloc/book_bloc.dart';

import 'package:e_library/injection_container.dart'
;
class GutenbergApp extends StatelessWidget {
  const GutenbergApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<BookBloc>()),
        BlocProvider(create: (_) => sl<SavedBooksBloc>()),
      ],
      child: MaterialApp(
        title: 'Gutenberg Reader',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const LoginPage(), // Change initial route to LoginPage
      ),
    );
  }
}