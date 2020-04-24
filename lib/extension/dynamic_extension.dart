import 'package:intl/intl.dart';

extension DynamicExtension on dynamic{
  DateTime toDateTime() {
    if (this == null || this == '') {
      return new DateTime.now();
    }
    RegExp _reExpNum = new RegExp(
        r"^\s*\d+\s*$",
        caseSensitive: false,
        multiLine: false
    );
    if (_reExpNum.hasMatch(this.toString()) == true) {
      return new DateTime.fromMillisecondsSinceEpoch(int.parse(this) * 1000);
    }
    RegExp _reExp = new RegExp(
        r"(\d{1,4})",
        caseSensitive: false,
        multiLine: false
    );
    final Iterable<Match> _matches = _reExp.allMatches(this.toString());
    int _index = 0;
    List<String> _formats = ['d', 'M', 'y', 'H', 'm', 's'];
    String _format = '';
    String _dateReFormat = '';
    for (Match m in _matches) {
      if (m.group(1) != null) {
        String _separation = '';
        if (_index < 5) {
          _separation = (_index < 2) ? "/" : (_index == 2) ? " " : ":";
        }
        _format += '${_formats[_index]}$_separation';
        _dateReFormat += '${m.group(1)}$_separation';
      }
      _index++;
    }
    return DateFormat(_format).parse(_dateReFormat);
  }
  String date([String format]){
    String _format = format ?? 'dd/MM/yyyy';
    if(this != null) {
      if((this is String || this is num)) {
        return DateFormat(_format).format(this.toString().toDateTime());
      }
    }
    return '';
  }
}
