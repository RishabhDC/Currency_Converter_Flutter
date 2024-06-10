import 'package:currency_converter/models/allCurrencies.dart';
import 'package:http/http.dart' as http;

import '../models/ratesmodel.dart';

Future<RatesModel> fetchrates() async {
  final response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/latest.json?app_id=4d62e980b3134a19bc1e071ddd660b6d'));
  print(response.body);
  final result = ratesModelFromJson(response.body);

  return result;
}

Future<Map> fetchcurrencies() async {
  final response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?app_id=4d62e980b3134a19bc1e071ddd660b6d'));
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}

String convertusd(Map exchangeRates, String usd, String currency) {
  String output =
  ((exchangeRates[currency] * double.parse(usd)).toStringAsFixed(2))
      .toString();
  return output;
}

String convertany(Map exchangeRates, String amount, String currencybase, String currencyfinal) {
  String output =
  ((double.parse(amount) / exchangeRates[currencybase]) * exchangeRates[currencyfinal])
      .toStringAsFixed(2).toString();
  return output;
}