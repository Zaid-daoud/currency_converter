import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../../core/constants/urls.dart';

part 'currency_model.g.dart';

@HiveType(typeId: 0)
class CurrencyModel extends Currency with HiveObjectMixin {
  CurrencyModel({
    @HiveField(0) super.code,
    @HiveField(1) super.symbol,
    @HiveField(2) super.symbolNative,
    @HiveField(3) super.decimalDigits,
    @HiveField(4) super.rounding,
    @HiveField(5) super.name,
    @HiveField(6) super.namePlural,
    @HiveField(7) super.exchangeRate,
  }) {
    flag = "${Urls.countriesBaseUrl}${code?.substring(0, (code?.length ?? 1) - 1).toLowerCase()}.svg";
  }

  CurrencyModel.fromJson(dynamic json) {
    symbol = json['symbol'];
    name = json['name'];
    symbolNative = json['symbol_native'];
    decimalDigits = json['decimal_digits'];
    rounding = json['rounding'];
    code = json['code'];
    namePlural = json['name_plural'];
    exchangeRate = json['exchangeRate'];
    flag = "${Urls.countriesBaseUrl}${code?.substring(0, (code?.length ?? 1) - 1).toLowerCase()}.svg";
  }

  CurrencyModel copyWith({
    String? symbol,
    String? name,
    String? symbolNative,
    num? decimalDigits,
    num? rounding,
    String? code,
    String? namePlural,
    num? exchangeRate,
  }) =>
      CurrencyModel(
        symbol: symbol ?? this.symbol,
        name: name ?? this.name,
        symbolNative: symbolNative ?? this.symbolNative,
        decimalDigits: decimalDigits ?? this.decimalDigits,
        rounding: rounding ?? this.rounding,
        code: code ?? this.code,
        namePlural: namePlural ?? this.namePlural,
        exchangeRate: exchangeRate ?? this.exchangeRate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['symbol'] = symbol;
    map['name'] = name;
    map['symbol_native'] = symbolNative;
    map['decimal_digits'] = decimalDigits;
    map['rounding'] = rounding;
    map['code'] = code;
    map['name_plural'] = namePlural;
    map['exchangeRate'] = exchangeRate;
    return map;
  }
}
