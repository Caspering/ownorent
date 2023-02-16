import 'dart:io';

import 'package:intl/intl.dart';

String formatMoney(money) {
  var formatter = NumberFormat('#,###,000');
  return formatter.format(money);
}

String getCurrency() {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  return format.currencySymbol;
}
