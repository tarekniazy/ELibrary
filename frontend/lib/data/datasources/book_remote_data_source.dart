import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<BookModel> getBook(String bookId);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final http.Client client;
  static const String corsProxy = 'https://api.allorigins.win/raw?url=';

  BookRemoteDataSourceImpl({required this.client});

  @override
  Future<BookModel> getBook(String bookId) async {
    try {
      final contentUrl = _getContentUrl(bookId);
      final metadataUrl = _getMetadataUrl(bookId);

      final contentResponse = await client.get(Uri.parse(contentUrl));
      final metadataResponse = await client.get(Uri.parse(metadataUrl));

      if (contentResponse.statusCode != 200 || metadataResponse.statusCode != 200) {
        throw Exception('Failed to load book');
      }

      final content = utf8.decode(contentResponse.bodyBytes);
      final document = parse(metadataResponse.body);
      
      final title = document.querySelector('title')?.text ?? 'Unknown Title';
      final language = document.querySelector('html')?.attributes['lang'] ?? 'en';

      return BookModel(
        content: content,
        metadata: metadataResponse.body,
        title: title,
        language: language,
      );
    } catch (e) {
      throw Exception('Error fetching book: $e');
    }
  }

  String _getContentUrl(String bookId) =>
      '$corsProxy${Uri.encodeComponent('https://www.gutenberg.org/files/$bookId/$bookId-0.txt')}';

  String _getMetadataUrl(String bookId) =>
      '$corsProxy${Uri.encodeComponent('https://www.gutenberg.org/ebooks/$bookId')}';
}