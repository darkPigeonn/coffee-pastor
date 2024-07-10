import 'package:flutter_coffee_application/resource/model/quote_model.dart';
import 'package:flutter_coffee_application/resource/services/api/quote_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quoteServices = Provider<QuoteServices>((ref) => QuoteServices());
final quoteProvider = FutureProvider<List<ModelQuote>>((ref) async {
  return ref.read(quoteServices).getQuotes();
});

final todayQuoteProvider = FutureProvider<ModelQuote>((ref) async {
  return ref.read(quoteServices).getTodayQuote();
});