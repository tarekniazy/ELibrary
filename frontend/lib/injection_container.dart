import 'package:e_library/data/datasources/auth_remote_data_source.dart';
import 'package:e_library/data/datasources/saved_book_remote_data_source.dart';
import 'package:e_library/data/repositories/auth_repository_impl.dart';
import 'package:e_library/data/repositories/saved_book_respository_impl.dart';
import 'package:e_library/domain/repositories/auth_repository.dart';
import 'package:e_library/domain/repositories/saved_book_repository.dart';
import 'package:e_library/domain/usecases/login.dart';
import 'package:e_library/domain/usecases/logout.dart';
import 'package:e_library/domain/usecases/register.dart';
import 'package:e_library/domain/usecases/save_book.dart';
import 'package:e_library/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'data/repositories/book_repository_impl.dart';
import 'data/datasources/book_remote_data_source.dart';
import 'domain/repositories/book_repository.dart';
import 'domain/usecases/get_book.dart';
import 'presentation/bloc/book_bloc/book_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Bloc
  sl.registerFactory(() => BookBloc(getBook: sl(), saveBook: sl(), storage: GetIt.I<FlutterSecureStorage>()));
  sl.registerFactory(
    () => AuthBloc(
      login: sl(),
      register: sl(),
      logout: sl(),
      storage: GetIt.I<FlutterSecureStorage>(), // Inject storage
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetBook(sl()));
  sl.registerLazySingleton(() => SaveBook(sl()));

  // Repository
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSourceImpl(client: sl()),
  );

    // Repository
  sl.registerLazySingleton<SavedBookRemoteDataSource>(
    () => SavedBookRemoteDataSourceImpl(client: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SavedBookRepository>(
    () => SavedBookRepositoryImpl(remoteDataSource: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());


  // Auth Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  // Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Auth Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
}