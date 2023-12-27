
import 'package:currency_formatter/currency_formatter.dart';

extension StringExtension on String {
  String toCurrency() {
  //   // CurrencyFormatter cf = CurrencyFormatter();
  //   const CurrencyFormat cf = CurrencyFormat(
  //   // formatter settings for euro
  //   code: 'eur',
  //   symbol: '€',
  //   symbolSide: SymbolSide.right,
  //   thousandSeparator: '.',
  //   decimalSeparator: ',',
  //   symbolSeparator: ' ',
  // );
    // ignore: deprecated_member_use
    CurrencyFormatterSettings nairaSettings = const CurrencyFormatterSettings(
      symbol:'NGN',
      symbolSide: SymbolSide.left,
      thousandSeparator: ',',
      decimalSeparator: '.',
    );
    String formatted =  CurrencyFormatter.format(double.parse(this), nairaSettings);
    return formatted;
  }

  String capitalizeFirstChar() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}