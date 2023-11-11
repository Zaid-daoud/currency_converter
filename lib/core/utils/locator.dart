import 'package:currency_converter/features/supported_currencies/data/data_source/local_data_source/currencies_local_data_source.dart.dart';
import 'package:currency_converter/features/supported_currencies/data/data_source/remote_data_source/currencies_remote_data_source.dart';
import 'package:currency_converter/features/supported_currencies/data/repositories/currencies_repository.dart';
import 'package:currency_converter/features/supported_currencies/domain/repository/supported_currencies_repository.dart';
import 'package:currency_converter/features/supported_currencies/domain/use_cases/convert_currency_use_case.dart';
import 'package:currency_converter/features/supported_currencies/domain/use_cases/get_currencies_history_use_case.dart';
import 'package:currency_converter/features/supported_currencies/domain/use_cases/get_supported_currencies_use_case.dart';
import 'package:get_it/get_it.dart';

import '../../features/supported_currencies/domain/use_cases/save_supported_currencies_use_case.dart';

final locator = GetIt.instance;

void setupGetIt() {
  locator.registerLazySingleton<ISupportedCurrenciesRepository>(() => CurrenciesRepository());
  locator.registerLazySingleton<GetSupportedCurrenciesUseCase>(() => GetSupportedCurrenciesUseCase());
  locator.registerLazySingleton<SaveSupportedCurrenciesUseCase>(() => SaveSupportedCurrenciesUseCase());
  locator.registerLazySingleton<ConvertCurrencyUseCase>(() => ConvertCurrencyUseCase());
  locator.registerLazySingleton<GetCurrenciesHistoryUseCase>(() => GetCurrenciesHistoryUseCase());
  locator.registerLazySingleton<CurrenciesRepository>(() => CurrenciesRepository());
  locator.registerLazySingleton<CurrenciesRemoteDatasource>(() => CurrenciesRemoteDatasource());
  locator.registerLazySingleton<CurrenciesLocalDatasource>(() => CurrenciesLocalDatasource());
}
