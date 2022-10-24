import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Utils {
  static MethodChannel get methodChannel => const MethodChannel('plugins.wayapay/wayapay_flutter');

  static String getKeyErrorMsg(String keyType) {
    return 'Invalid $keyType key. You must use a valid $keyType key. Ensure that you '
        'have set a $keyType key. Check http://wayapay.co for more';
  }

  static NumberFormat? _currencyFormatter;

  static setCurrencyFormatter(String? currency, String? locale) =>
      _currencyFormatter =
          NumberFormat.currency(locale: locale, name: '$currency\u{0020}');

  static String formatAmount(num amountInBase) {
    if (_currencyFormatter == null) throw "Currency formatter not initialized.";
    return _currencyFormatter!.format((amountInBase));
  }

  /// Add double spaces after every 4th character
  static String addSpaces(String text) {
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    return buffer.toString();
  }
  static const _chars = '1234567890';
  static final Random _rnd = Random();

  static String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
