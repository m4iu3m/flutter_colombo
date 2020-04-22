import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime{
  String toStr(){
    return DateFormat('dd/MM/yyyy').format(this);
  }
  int toUnixStamp(){
    return (this.toUtc().millisecondsSinceEpoch/1000).ceil();
  }
}