import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';

abstract class SupportedCurrencyStates {}

class SupportedCurrencyInitialState extends SupportedCurrencyStates {}

class SupportedCurrencyErrorState extends SupportedCurrencyStates {
  final String? message;
  SupportedCurrencyErrorState({this.message});
}

class SupportedCurrencyLoadingState extends SupportedCurrencyStates {}

class SupportedCurrencyNoDataState extends SupportedCurrencyStates {}

class SupportedCurrencySavedState extends SupportedCurrencyStates {}

class SupportedCurrencyLoadedState extends SupportedCurrencyStates {
  final List<Currency> data;

  SupportedCurrencyLoadedState(this.data);
}
