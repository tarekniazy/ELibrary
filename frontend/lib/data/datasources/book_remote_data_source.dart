import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<BookModel> getBook(String bookId);
  Future<String> analyzeSentiment(String text);

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
        gutenbergId: bookId,
        content: content,
        metadata: metadataResponse.body,
        title: title,
        language: language,
        textAnalysis: '',
      );
    } catch (e) {
      throw Exception('Error fetching book: $e');
    }
  }

    @override
  Future<String> analyzeSentiment(String text) async {
    String apiKey = 'AIzaSyAhF5Cxnd6lk5h_1jaIz5lNVaAGC9UmgD8'; // Replace with your actual API key
    String model = 'gemini-1.5-flash'; // Or the model you want to use
  final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey');

  final headers = {
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    'contents': [
      {'parts': [{'text': 'Generate a sentiment analysis for the following text: $text'}]}
    ]
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      // Check if 'candidates' exists and has content
      if (jsonData.containsKey('candidates') &&
          jsonData['candidates'] is List &&
          jsonData['candidates'].isNotEmpty) {
        
        var content = jsonData['candidates'][0]['content'];
        
        if (content.containsKey('parts') &&
            content['parts'] is List &&
            content['parts'].isNotEmpty &&
            content['parts'][0].containsKey('text')) {
          
          return content['parts'][0]['text']; // Extracts only the text
        }      
        else {
        print("Unexpected JSON response structure: $jsonData"); // Debug
        return Future.value(""); // Correct: Returning Future<String>
      }
      }
      else {
      print("Unexpected JSON response structure: $jsonData"); // Debug
      return Future.value(""); // Correct: Returning Future<String>
      }
      
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}'); // Print the error response
        return Future.value(""); // Correct: Returning Future<String>
    }
  } catch (e) {
    print('Error: $e');
        return Future.value(""); // Correct: Returning Future<String>
  }
  }

  String _getContentUrl(String bookId) =>
      '$corsProxy${Uri.encodeComponent('https://www.gutenberg.org/files/$bookId/$bookId-0.txt')}';

  String _getMetadataUrl(String bookId) =>
      '$corsProxy${Uri.encodeComponent('https://www.gutenberg.org/ebooks/$bookId')}';
}