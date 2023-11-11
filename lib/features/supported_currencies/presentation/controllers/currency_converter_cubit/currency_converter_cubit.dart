import 'package:currency_converter/core/utils/locator.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency_history.dart';
import 'package:currency_converter/features/supported_currencies/domain/use_cases/convert_currency_use_case.dart';
import 'package:currency_converter/features/supported_currencies/domain/use_cases/get_currencies_history_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'currency_converter_states.dart';

class CurrencyConverterCubit extends Cubit<CurrencyConverterStates> {
  Currency? base, target;
  List<CurrencyHistory>? history;
  final controller = TextEditingController(text: "00.00");
  CurrencyConverterCubit() : super(CurrencyConverterInitialState(value: 00.00));

  Future getResult(BuildContext context, num? value) async {
    final selectionResult = _checkIfCurrenciesSelected(context);
    if (selectionResult) {
      if (state is CurrencyConverterLoadingState) return;
      emit(CurrencyConverterLoadingState(value: 0.00));
      if (value == null) {
        emit(CurrencyNewStateState(value: 0.00));
      } else {
        final result = await locator.get<ConvertCurrencyUseCase>().call(base!, target!, value);
        final historyResult = await locator.get<GetCurrenciesHistoryUseCase>().call(
              base!,
              target!,
              DateTime.now().subtract(const Duration(days: 7)),
              value,
            );
        historyResult.fold((l) => null, (r) => history = r);
        result.fold((l) => null, (value) => emit(CurrencyNewStateState(value: value)));
      }
    }
  }

  bool _checkIfCurrenciesSelected(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (target == null || base == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have to select: ${target == null ? "- Target Currency" : ""}  ${base == null ? "- Base Currency" : ""}'),
          duration: const Duration(seconds: 1),
        ),
      );
      emit(CurrencyConverterInitialState(value: 00.00));
      return false;
    }
    return true;
  }
}
