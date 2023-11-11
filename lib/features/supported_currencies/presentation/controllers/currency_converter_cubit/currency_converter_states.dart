abstract class CurrencyConverterStates {
  num? value;

  CurrencyConverterStates({this.value});
}

class CurrencyConverterInitialState extends CurrencyConverterStates {
  CurrencyConverterInitialState({super.value});
}

class CurrencyConverterLoadingState extends CurrencyConverterStates {
  CurrencyConverterLoadingState({super.value});
}

class CurrencyNewStateState extends CurrencyConverterStates {
  CurrencyNewStateState({super.value});
}
