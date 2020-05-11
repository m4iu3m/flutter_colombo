import 'package:intl/intl.dart';

extension DynamicExtension on dynamic{

  String number([String suffix]){
    final _number = new NumberFormat("#,##0", "vi_VN");
    String _result = '0';
    _result = _number.format(int.parse(this.toString())).toString();
    _result = (suffix != null)?'$_result$suffix':_result;
    return _result;
  }

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
  bool empty(){
    return (this == null || this.toString().trim() == '');
  }
  bool invalidEmail(){
    if(this != null && this.toString().trim() != '') {
      RegExp _reExp = new RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
          caseSensitive: false,
          multiLine: false
      );
      return !_reExp.hasMatch(this);
    }else{
      return false;
    }
  }
}
