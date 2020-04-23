import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormRadio extends StatefulWidget {
  final Function onChange;
  final Map<String, String> listValues;
  String groupValue;
  final double space;
  final Axis direction;

  FormRadio({Key key, this.onChange, this.listValues, this.groupValue:'', this.space:10.0, this.direction:Axis.horizontal}) : super(key: key);
  @override
  _FormRadioState createState() => _FormRadioState();
}

class _FormRadioState extends State<FormRadio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _listRadio()
    );
  }
  Widget _listRadio(){
    List<Widget> _list = <Widget>[];
    int i = 1;
    widget.listValues.forEach((key, value) {
      _list.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
            width: 30,
            child: Radio(
                value: key,
                groupValue: widget.groupValue,
                onChanged: (val) {
                  widget.onChange(val);
                  setState(() {
                    widget.groupValue = val;
                  });
                }
            ),
          ),
          Text(value.toString()),
        ],
      ));
      if(i < widget.listValues.length){
        _list.add(SizedBox(width: widget.space,));
      }
      i++;
    });
    if(widget.direction == Axis.vertical){
      return Column(
        children: _list,
      );
    }
    return Row(
      children: _list,
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
