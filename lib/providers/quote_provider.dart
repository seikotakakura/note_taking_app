import 'package:note_taking_app/models/quote_model.dart';
import 'package:note_taking_app/models/random_quote_model.dart';
import 'package:note_taking_app/services/api_services.dart';
import 'package:riverpod/riverpod.dart';

final apiServiceProvider = Provider((ref) => ApiServices());

final quoteProvider = FutureProvider<RandomQuoteModel>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.fetchRandomQuote();
});
// final quoteProvider = FutureProvider<QuoteModel>((ref) async {
//   final apiService = ref.watch(apiServiceProvider);
//   return await apiService.fetchRandomQuote();
// });
