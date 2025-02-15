import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:e_library/data/models/saved_book_model.dart';

abstract class SavedBookRemoteDataSource {
  Future<List<SavedBookModel>> getSavedBooks(String userId, String token);
  Future<void> saveBook(SavedBookModel savedBookModel, String token);
  Future<void> deleteBook(int id);
}

class SavedBookRemoteDataSourceImpl implements SavedBookRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'http://108.129.133.132:80/api/Books';

    SavedBookRemoteDataSourceImpl({required this.client});

  @override
Future<List<SavedBookModel>> getSavedBooks(String userId, String token) async {
  final url = '$baseUrl/$userId';
  
  try {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json as List).map((book) => SavedBookModel.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load saved books: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Network error: $e');
  }
}

  @override
  Future<void> saveBook(SavedBookModel savedBookModel, String token) async {
    try {
      
      final response = await client.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(savedBookModel.toJson()),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Save failed: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBook(int id) async {
    final response = await client.delete(Uri.parse(baseUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete book');
    }
  }

}