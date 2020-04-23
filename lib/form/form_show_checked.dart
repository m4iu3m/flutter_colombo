import 'package:flutter/material.dart';
import 'form_checkbox.dart';

// ignore: must_be_immutable
class FormShowChecked extends StatefulWidget {
  final String label;
  final bool fullWidth;
  bool value;
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FormCheckbox(
            fullWidth: widget.fullWidth,
            label: widget.label,
            value: widget.value,
            onChange: (val) {
              setState(() {
                widget.value = val;
              });
              widget.onChange(val);
            },
          ),
          (widget.child != null && widget.value == true)?widget.child:Container()
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
