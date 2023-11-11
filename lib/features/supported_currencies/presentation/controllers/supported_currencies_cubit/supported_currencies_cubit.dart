import 'package:currency_converter/core/utils/exceptions.dart';
import 'package:currency_converter/core/utils/locator.dart';
import 'package:currency_converter/core/utils/use_case.dart';
import 'package:currency_converter/features/supported_currencies/data/models/currency_model/currency_model.dart';
import 'package:currency_converter/features/supported_currencies/domain/use_cases/get_supported_currencies_use_case.dart';
import 'package:currency_converter/features/supported_currencies/domain/use_cases/save_supported_currencies_use_case.dart';
import 'package:currency_converter/features/supported_currencies/presentation/controllers/supported_currencies_cubit/supported_currency_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupportedCurrenciesCubit extends Cubit<SupportedCurrencyStates> {
  SupportedCurrenciesCubit() : super(SupportedCurrencyInitialState());

  Future<void> getSupportedCurrencies() async {
    emit(SupportedCurrencyLoadingState());
    final result = await locator.get<GetSupportedCurrenciesUseCase>().call(NoParams());
    result.fold(
      (exception) => emit(
        SupportedCurrencyErrorState(
            message: exception is ServerException
                ? exception.message
                : exception is CacheException
                    ? exception.message
                    : ""),
      ),
      (data) => data.isEmpty ? emit(SupportedCurrencyNoDataState()) : emit(SupportedCurrencyLoadedState(data)),
    );
  }

  Future<void> saveSupportedCurrencies(List<CurrencyModel> currencies) async {
    if (state is SupportedCurrencyLoadingState) return;
    emit(SupportedCurrencyLoadingState());
    final result = await locator.get<SaveSupportedCurrenciesUseCase>().call(currencies);
    result.fold(
      (exception) => emit(SupportedCurrencyErrorState(message: exception is CacheException ? exception.message : "")),
      (data) => emit(SupportedCurrencySavedState()),
    );
  }
}
