import 'package:currency_converter/core/utils/locator.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:currency_converter/features/supported_currencies/domain/repository/supported_currencies_repository.dart';
import 'package:dartz/dartz.dart';

class ConvertCurrencyUseCase {
  Future<Either<Exception, num>> call(Currency base, Currency target, num baseValue) async {
    return locator.get<ISupportedCurrenciesRepository>().convertCurrency(base, target, baseValue);
  }
}
