import 'package:e_library/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_library/presentation/bloc/auth_bloc/auth_events.dart';
import 'package:e_library/presentation/bloc/auth_bloc/auth_states.dart';
import 'package:e_library/presentation/bloc/saved_book_bloc/saved_book_bloc.dart';
import 'package:e_library/presentation/bloc/saved_book_bloc/saved_book_event.dart';
import 'package:e_library/presentation/pages/home_page.dart';
import 'package:e_library/presentation/pages/login_page.dart';
import 'package:e_library/presentation/pages/saved_books_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Gutenberg Reader',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // If not already on HomePage, navigate to HomePage
              if (ModalRoute.of(context)?.settings.name != '/') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              }
            },
          ),
        ListTile(
          leading: const Icon(Icons.bookmark),
          title: const Text('Saved Books'),
          onTap: () {
            context.read<SavedBooksBloc>().add(LoadSavedBooksEvent());
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: context.read<SavedBooksBloc>(),
                  child: const SavedBooksPage(),
                ),
              ),
            );
          },
        ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  context.read<AuthBloc>().add(LogoutEvent());
                },
              );
            },
          ),
        ],
      ),
    );
  }
}