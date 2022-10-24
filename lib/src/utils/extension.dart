
import 'package:currency_formatter/currency_formatter.dart';

extension StringExtension on String {
  String toCurrency() {
    CurrencyFormatter cf = CurrencyFormatter();
    CurrencyFormatterSettings nairaSettings = CurrencyFormatterSettings(
      symbol:'NGN',
      symbolSide: SymbolSide.left,
      thousandSeparator: ',',
      decimalSeparator: '.',
    );
    String formatted = cf.format(double.parse(this), nairaSettings);
    return formatted;
  }

  String capitalizeFirstChar() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}