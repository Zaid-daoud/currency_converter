import 'dart:developer';

import 'package:currency_converter/core/utils/exceptions.dart';
import 'package:currency_converter/features/supported_currencies/data/models/currency_model/currency_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../../core/constants/keys.dart';

class CurrenciesLocalDatasource {
  Future<List<CurrencyModel>> getSupportedCurrencies() async {
    try {
      var box = Hive.box(Keys.currencyBoxKey);
      List<CurrencyModel> data = [];
      box.toMap().forEach((key, value) {
        data.add(CurrencyModel.fromJson(value));
      });
      return data;
    } catch (e) {
      log(e.toString());
      throw CacheException(message: e.toString());
    }
  }

  void saveSupportedCurrencies(List<CurrencyModel> currencies) async {
    try {
      var box = Hive.box(Keys.currencyBoxKey);
      for (CurrencyModel model in currencies) {
        await box.put(model.code, model.toJson());
      }
    } catch (e) {
      log(e.toString());
      throw CacheException(message: e.toString());
    }
  }
}
