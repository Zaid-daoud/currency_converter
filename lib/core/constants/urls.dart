import 'package:currency_converter/core/constants/keys.dart';

class Urls {
  static const String countriesBaseUrl = "https://flagcdn.com/";
  static const String currenciesBaseUrl = "https://api.freecurrencyapi.com/v1/";
  static const String getSupportedCurrencies = "${currenciesBaseUrl}currencies?apikey=${Keys.currencyApiKey}";
  static const String getLatestExchangeRate = "${currenciesBaseUrl}latest?apikey=${Keys.currencyApiKey}";
  static const String getHistorical = "${currenciesBaseUrl}historical?apikey=${Keys.currencyApiKey}";
}
