import 'package:dio/dio.dart';
import 'package:note_taking_app/models/quote_model.dart';

class ApiServices {
  final Dio _dio = Dio();

  Future<QuoteModel> fetchRandomQuote() async {
    try {
      final response = await _dio.get('https://api.quotable.io/random');
      return QuoteModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch Quotes: $e');
    }
  }
}
