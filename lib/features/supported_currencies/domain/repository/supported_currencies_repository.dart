import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency_history.dart';
import 'package:dartz/dartz.dart';

abstract class ISupportedCurrenciesRepository {
  Future<Either<Exception, List<Currency>>> getSupportedCurrencies();
  Future<Either<Exception, void>> saveSupportedCurrencies(List<Currency> currencies);
  Future<Either<Exception, num>> convertCurrency(Currency base, Currency target, num baseValue);
  Future<Either<Exception, List<CurrencyHistory>>> getCurrenciesHistory(Currency base, Currency target, DateTime date, num value);
}
