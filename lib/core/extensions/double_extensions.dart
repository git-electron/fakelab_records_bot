import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  String get inCurrency {
    final NumberFormat priceFormatter = NumberFormat('#,##0.00', 'en_US');
    return priceFormatter.format(this);
  }

  String get inCurrencyRounded {
    final NumberFormat priceFormatter = NumberFormat('#,##0', 'en_US');
    return priceFormatter.format(this);
  }
}
