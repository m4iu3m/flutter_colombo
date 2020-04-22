import 'package:flutter/material.dart';
import 'form_checkbox.dart';

class FormShowChecked extends StatefulWidget {
  final String label;
  final bool fullWidth;
  final bool value;
  final Widget child;
  final Function onChange;
  FormShowChecked({
    this.fullWidth:false,
    this.label:'',
    this.value:false,
    this.child,
    this.onChange
  });

  @override
  _FormShowCheckedState createState() => _FormShowCheckedState();
}

class _FormShowCheckedState extends State<FormShowChecked> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FormCheckbox(
            fullWidth: widget.fullWidth,
            label: widget.label,
            value: _value,
            onChange: (val) {
              setState(() {
                _value = val;
              });
              widget.onChange(val);
            },
          ),
          (widget.child != null && _value == true)?widget.child:Container()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }
}
