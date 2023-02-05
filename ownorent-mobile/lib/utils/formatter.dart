import 'package:intl/intl.dart';

String formatMoney(money) {
  var formatter = NumberFormat('#,###,000');
  return formatter.format(money);
}
