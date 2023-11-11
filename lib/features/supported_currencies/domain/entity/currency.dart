abstract class Currency {
  String? symbol;
  String? name;
  String? symbolNative;
  num? decimalDigits;
  num? rounding;
  String? code;
  String? namePlural;
  String? flag;
  num? exchangeRate;

  Currency({
    this.symbol,
    this.name,
    this.symbolNative,
    this.decimalDigits,
    this.rounding,
    this.code,
    this.namePlural,
    this.exchangeRate,
    this.flag,
  });
}
