import 'package:currency_converter/core/utils/locator.dart';
import 'package:currency_converter/core/utils/use_case.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:currency_converter/features/supported_currencies/domain/repository/supported_currencies_repository.dart';
import 'package:dartz/dartz.dart';

class GetSupportedCurrenciesUseCase implements IUseCase<List<Currency>, NoParams> {
  @override
  Future<Either<Exception, List<Currency>>> call(NoParams params) async {
    return locator.get<ISupportedCurrenciesRepository>().getSupportedCurrencies();
  }
}
