import 'package:flutter/material.dart';

import '../global.dart';
// ignore: must_be_immutable
class FormCheckbox extends StatefulWidget {
  bool value;
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
                value: widget.value??false,
                onChanged: (val) {
                  widget.onChange(val);
                  setState(() {
                    widget.value = val;
                  });
                }
            ),
          )
        ],
      ),
    );
  }
}
