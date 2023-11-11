import 'package:currency_converter/core/utils/locator.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency_history.dart';
import 'package:currency_converter/features/supported_currencies/domain/repository/supported_currencies_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrenciesHistoryUseCase {
  Future<Either<Exception, List<CurrencyHistory>>> call(Currency base, Currency target, DateTime date, num value) async {
    return locator.get<ISupportedCurrenciesRepository>().getCurrenciesHistory(base, target, date, value);
  }
}
