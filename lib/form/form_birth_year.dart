import 'package:flutter/material.dart';
import 'package:flutter_colombo/form.dart';

class FormBirthYear extends StatefulWidget {
  final String label, errorText, value;
  final Function onChange;

  const FormBirthYear({Key key, this.label, this.errorText,@required this.onChange, this.value}) : super(key: key);
  @override
  _FormBirthYearState createState() => _FormBirthYearState();
}

class _FormBirthYearState extends State<FormBirthYear> {
  String _value;
  final _year = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    _value = (widget.value)??_value;
    return Container(
      child: _buildSelect(),
    );
  }
  Widget _buildSelect(){
    Map<String, String>_years = {};
    int _min = _year - 110;
    for(int i = _year; i >= _min; i--){
      _years.putIfAbsent(i.toString(), () => i.toString());
    }
    return FormSelect(
      labelText: widget.label,
      errorText: widget.errorText,
      value: _value,
      items: _years,
      onChange: (val){
        widget.onChange(val);
        setState(() => _value = val);
      },
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}