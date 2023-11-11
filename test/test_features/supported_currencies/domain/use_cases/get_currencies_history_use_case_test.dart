import 'package:currency_converter/core/utils/locator.dart';
import 'package:currency_converter/features/supported_currencies/data/models/currency_model/currency_model.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency_history.dart';
import 'package:currency_converter/features/supported_currencies/domain/use_cases/get_currencies_history_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    setupGetIt();
  });
  group('Get Currencies History', () {
    test('Currency history for the last 7 days should be retrieved', () async {
      int length = 7;
      Currency base = CurrencyModel(code: "EUR");
      Currency target = CurrencyModel(code: "USD");
      DateTime date = DateTime.now().subtract(Duration(days: length));
      final result = await locator.get<GetCurrenciesHistoryUseCase>().call(base, target, date, 22.5);

      expect(result.fold((l) => l, (data) => data), isA<List<CurrencyHistory>>());
      expect(result.fold((l) => l, (data) => data.length), length);
    });
  });
}
