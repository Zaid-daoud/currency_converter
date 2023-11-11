import 'package:currency_converter/core/utils/locator.dart';
import 'package:currency_converter/features/supported_currencies/data/models/currency_model/currency_model.dart';
import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:currency_converter/features/supported_currencies/domain/use_cases/convert_currency_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    setupGetIt();
  });
  group('Convert Currency', () {
    test('Converting currency should be successful', () async {
      Currency base = CurrencyModel(code: "EUR");
      Currency target = CurrencyModel(code: "USD");
      final result = await locator.get<ConvertCurrencyUseCase>().call(base, target, 22.5);

      expect(result.fold((l) => l, (number) => number), isA<num>());
    });
  });
}
