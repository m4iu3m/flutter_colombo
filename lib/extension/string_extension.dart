import 'package:intl/intl.dart';

extension StringExtension on String {
  int parseInt() {
    return int.parse(this);
  }
  double parseDouble() {
    return double.parse(this);
  }
  bool isPhoneVN(){
    RegExp _regExp = new RegExp(
      r"^(0|\+?84)(9[0-9]|8[1-9]|7[0,6-9]|5[6,8,9]|3[2-9]|2\d{2})\d{7}$",
      caseSensitive: false,
      multiLine: false,
    );
    return _regExp.hasMatch(this);
  }
  bool isEmail(){
    RegExp _reExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
        caseSensitive: false,
        multiLine: false
    );
    return _reExp.hasMatch(this);
  }
  bool notEmpty(){
    return (this != null && this.trim() != '');
  }
  DateTime toDateTime(){
    String _date = DateFormat('dd/MM/yyyy').format(new DateTime.now());
    RegExp _reExp = new RegExp(
        r"^\s*(\d{1,2})[\-\/]{1}(\d{1,2})[\-\/]{1}(\d{4}|\d{2})\s*$",
        caseSensitive: false,
        multiLine: false
    );
    if(_reExp.hasMatch(this) == true){
      final int _currentYear = DateTime.now().year.toString().substring(2).parseInt(),
          _currentStart = DateTime.now().year.toString().substring(0,2).parseInt();
      final Iterable<Match> _matches = _reExp.allMatches(this);
      for (Match m in _matches) {
        String _day = (m.group(1).toString().length == 1)?m.group(1):'0${m.group(1)}',
            _month = (m.group(2).toString().length == 1)?m.group(2):'0${m.group(2)}',
            _year = m.group(3);
        if(_year.toString().length == 2){
          if(_year.parseInt() <= _currentYear){
            _year = '$_currentStart$_year';
          }else{
            _year = '${_currentStart - 1}$_year';
          }
        }
        _date = '$_day/$_month/$_year';
      }
    }
    return new DateFormat("dd/MM/yyyy").parse(_date);
  }
}