import 'dart:developer';

import 'package:currency_converter/core/utils/exceptions.dart';
import 'package:currency_converter/features/supported_currencies/data/data_source/local_data_source/currencies_local_data_source.dart.dart';
import 'package:currency_converter/features/supported_currencies/data/data_source/remote_data_source/currencies_remote_data_source.dart';
import 'package:currency_converter/features/supported_currencies/data/models/currency_history_model.dart';
import 'package:currency_converter/features/supported_currencies/data/models/currency_model/currency_model.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:currency_converter/features/supported_currencies/domain/repository/supported_currencies_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/locator.dart';

class CurrenciesRepository implements ISupportedCurrenciesRepository {
  @override
  Future<Either<Exception, List<Currency>>> getSupportedCurrencies() async {
    try {
      final localResult = await locator.get<CurrenciesLocalDatasource>().getSupportedCurrencies();
      if (localResult.isEmpty) {
        final remoteResult = await locator.get<CurrenciesRemoteDatasource>().getSupportedCurrencies();
        saveSupportedCurrencies(remoteResult);
        log("Remote DB");
        return Right(remoteResult);
      }
      log("Local DB");
      return Right(localResult);
    } on ServerException catch (e) {
      return Left(e);
    } on CacheException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> saveSupportedCurrencies(covariant List<CurrencyModel> currencies) async {
    try {
      return Right(locator.get<CurrenciesLocalDatasource>().saveSupportedCurrencies(currencies));
    } on CacheException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, num>> convertCurrency(Currency base, Currency target, num baseValue) async {
    try {
      return Right(await locator.get<CurrenciesRemoteDatasource>().convertCurrency(base, target, baseValue));
    } on CacheException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<CurrencyHistoryModel>>> getCurrenciesHistory(Currency base, Currency target, DateTime date, num value) async {
    try {
      final List<CurrencyHistoryModel> list = [];
      for (int i = 0; i < (DateTime.now().difference(date).inDays); i++) {
        final current = date.add(Duration(days: i));
        final data = await locator.get<CurrenciesRemoteDatasource>().getCurrenciesHistory(base, target, current, value);
        list.add(data);
      }
      return Right(list);
    } on CacheException catch (e) {
      return Left(e);
    }
  }
}
