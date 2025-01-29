import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:note_taking_app/models/quote_model.dart';
import 'package:note_taking_app/models/random_quote_model.dart';

class ApiServices {
  final Dio _dio = Dio()
    ..httpClientAdapter = IOHttpClientAdapter()
    ..options.connectTimeout = Duration(seconds: 10)
    ..options.receiveTimeout = Duration(seconds: 10);

  Future<RandomQuoteModel> fetchRandomQuote() async {
    try {
      final response = await _dio.get('https://zenquotes.io/api/random');
      return RandomQuoteModel.fromJsonList(response.data);
    } catch (e) {
      log('Failed to fetch Quotes: $e');
      throw Exception('Failed to fetch Quotes: $e');
    }
  }

  // Future<QuoteModel> fetchRandomQuote() async {
  //   try {
  //     final response = await _dio.get('https://api.quotable.io/random');
  //     return QuoteModel.fromJson(response.data);
  //   } catch (e) {
  //     log('Failed to fetch Quotes: $e');
  //     throw Exception('Failed to fetch Quotes: $e');
  //   }
  // }
}
