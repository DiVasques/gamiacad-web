import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toLocalDateString() {
    DateFormat formatter = DateFormat.yMd('pt_BR');
    return formatter.format(toLocal());
  }

  String toLocalDateExtendedString() {
    DateFormat formatter = DateFormat.yMMMMd('pt_BR');
    return formatter.format(toLocal());
  }

  String toLocalTimeString() {
    DateFormat formatter = DateFormat.Hm();
    return formatter.format(toLocal());
  }

  String toLocalDateTimeString() {
    DateFormat formatter = DateFormat.yMd('pt_BR').add_Hm();
    return formatter.format(toLocal());
  }
}
