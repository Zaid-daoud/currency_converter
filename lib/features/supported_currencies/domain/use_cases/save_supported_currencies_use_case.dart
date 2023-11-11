import 'package:currency_converter/core/utils/use_case.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:currency_converter/features/supported_currencies/domain/repository/supported_currencies_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/locator.dart';

class SaveSupportedCurrenciesUseCase implements IUseCase<void, List<Currency>> {
  @override
  Future<Either<Exception, void>> call(List<Currency> currencies) async {
    return locator.get<ISupportedCurrenciesRepository>().saveSupportedCurrencies(currencies);
  }
}
