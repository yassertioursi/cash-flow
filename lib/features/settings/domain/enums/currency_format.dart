
enum CurrencyFormat {

  symbol,

  code;

  static CurrencyFormat fromString(String currencyFormat) {
    return CurrencyFormat.values.firstWhere(
      (e) => e.toString() == currencyFormat || e.name == currencyFormat,
      orElse: () => CurrencyFormat.symbol,
    );
  }
}
