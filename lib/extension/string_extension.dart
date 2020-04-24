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
  double ratio(){
    if(this != null && this != ''){
      RegExp _reExp = new RegExp(
          r"(\d+)\:(\d+)",
          caseSensitive: false,
          multiLine: false
      );
      final Iterable<Match> _matches = _reExp.allMatches(this.toString());
      for (Match m in _matches) {
        double _ratio = int.parse(m.group(1)) / int.parse(m.group(2));
        return _ratio;
      }
    }
    return 16/9;
  }
  bool notEmpty(){
    return (this != null && this.trim() != '');
  }
}