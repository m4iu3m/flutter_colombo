import 'package:flutter/material.dart';
import '../global.dart';

class FormCheckbox extends StatefulWidget {
  final bool value;
  final String label;
  final ValueChanged onChange;
  final Color bgColor;
  final EdgeInsets padding;
  final bool fullWidth;
  FormCheckbox(
      {this.label,
      this.value,
      this.onChange,
      this.bgColor,
      this.padding,
      this.fullWidth: true});
  @override
  _FormCheckboxState createState() => _FormCheckboxState();
}

class _FormCheckboxState extends State<FormCheckbox> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: (widget.bgColor != null) ? widget.bgColor : Colors.transparent,
      padding: (widget.padding != null) ? widget.padding : null,
      child: Row(
        crossAxisAlignment: (widget.fullWidth == true)?CrossAxisAlignment.start:CrossAxisAlignment.center,
        mainAxisAlignment:(widget.fullWidth == true)?MainAxisAlignment.spaceBetween:MainAxisAlignment.start,
        children: <Widget>[
          (widget.fullWidth == true)?
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                widget.label,
                style: TextStyle(fontSize: 14),
              ),
            ),
          )
          :Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              widget.label,
              style: TextStyle(fontSize: fontSizeBase),
            ),
          ),
          SizedBox(
            height: 35,
            width: 30,
            child: Checkbox(
              value: _value,
              onChanged: (val) {
                widget.onChange(val);
                setState(() {
                  _value = val;
                });
              }
            ),
          )
        ],
      ),
    );
  }
}
