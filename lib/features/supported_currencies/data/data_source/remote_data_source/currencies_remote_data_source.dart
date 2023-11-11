import 'dart:developer';

import 'package:currency_converter/core/constants/urls.dart';
import 'package:currency_converter/core/utils/api_helper.dart';
import 'package:currency_converter/features/supported_currencies/data/models/currency_history_model.dart';
import 'package:currency_converter/features/supported_currencies/data/models/currency_model/currency_model.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:intl/intl.dart';

class CurrenciesRemoteDatasource {
  Future<List<CurrencyModel>> getSupportedCurrencies() async {
    try {
      final result = await ApiHelper.get(url: Urls.getSupportedCurrencies);
      final exchangeRate = await ApiHelper.get(url: "${Urls.getLatestExchangeRate}&base_currency=USD");
      log(exchangeRate.toString());
      final List<CurrencyModel> supportedCurrencies = [];
      result['data'].forEach((key, value) {
        final model = CurrencyModel.fromJson(value);
        final rate = exchangeRate['data'][key] as num;
        model.exchangeRate = rate;
        supportedCurrencies.add(model);
      });
      return supportedCurrencies;
    } catch (e) {
      rethrow;
    }
  }

  Future<num> convertCurrency(Currency base, Currency target, num baseValue) async {
    try {
      final exchangeRate = await ApiHelper.get(url: "${Urls.getLatestExchangeRate}&base_currency=${base.code}&currencies=${target.code}");
      return exchangeRate['data'][target.code] * baseValue;
    } catch (e) {
      rethrow;
    }
  }

  Future<CurrencyHistoryModel> getCurrenciesHistory(Currency base, Currency target, DateTime date, num value) async {
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final exchangeRate = await ApiHelper.get(
        url: "${Urls.getHistorical}&date=$formattedDate&base_currency=${base.code}&currencies=${target.code}",
      );
      final result = exchangeRate['data'] as Map<String, dynamic>;
      return CurrencyHistoryModel(date: formattedDate, code: target.code, value: (result[formattedDate][target.code] ?? 0) * value);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
