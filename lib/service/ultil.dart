import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('dd/MM');

formatDate(DateTime date) {
  return formatter.format(date);
}
