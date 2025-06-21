enum CurrencyEnum {
  usd("US Dollar", "USD"),
  euro("Euro", "EUR"),
  gbp("British Pound", "GBP"),
  jpy("Japanese Yen", "JPY"),
  vnd("Vietnamese Dong", "VND");

  final String name;
  final String code;

  const CurrencyEnum(this.name, this.code);

  String get getCurrencyName => name;
  String get getCurrencyCode => code;
}