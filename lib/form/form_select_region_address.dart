import 'package:flutter/material.dart';

import 'form_select.dart';

// ignore: must_be_immutable
class FormSelectRegionAddress extends StatefulWidget {
  final String domain;
  final Function onChangeProvince, onChangeDistrict, onChangeWard;
  final String errorProvince, errorDistrict, errorWard;
  final String labelProvince, labelDistrict, labelWard;
  String provinceId, districtId, wardId;

  FormSelectRegionAddress({
    Key key,
    @required this.onChangeProvince,
    @required this.onChangeDistrict,
    @required this.onChangeWard,
    this.errorProvince,
    this.errorDistrict,
    this.errorWard,
    this.provinceId,
    this.districtId,
    this.wardId,
    this.labelProvince,
    this.labelDistrict,
    this.labelWard,
    @required this.domain,
  }) : super(key: key);
  @override
  _FormSelectRegionAddressState createState() => _FormSelectRegionAddressState();
}

class _FormSelectRegionAddressState extends State<FormSelectRegionAddress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FormSelect(
              errorText: (widget.errorProvince != null)?widget.errorProvince:null,
              labelText: (widget.labelProvince != null)?widget.labelProvince:'Tỉnh, thành',
              service: widget.domain + "/api/Content/Region/selectProvinces",
              value: widget.provinceId,
              showSearch: true,
              onChange: (val) {
                widget.onChangeProvince(val);
                setState(() {
                  widget.provinceId = val;
                  widget.districtId = null;
                  widget.wardId = null;
                });
              },
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 1,
            child: FormSelect(
              labelText: (widget.labelDistrict != null)?widget.labelDistrict:'Quận, huyện',
              errorText: (widget.errorDistrict != null)?widget.errorDistrict:null,
              service: widget.domain + "/api/Content/Region/selectDistricts",
              extraParams: {'provinceId': widget.provinceId},
              value: widget.districtId,
              onChange: (val) {
                widget.onChangeDistrict(val);
                setState(() {
                  widget.districtId = val;
                  widget.wardId = null;
                });
              },
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
              flex: 1,
              child: FormSelect(
                labelText: (widget.labelWard != null)?widget.labelWard:'Phường, xã',
                errorText: (widget.errorWard != null)?widget.errorWard:null,
                service: widget.domain + "/api/Content/Region/selectWards",
                extraParams: {'districtId': widget.districtId},
                value: widget.wardId,
                onChange: (val) {
                  widget.onChangeWard(val);
                  setState(() {
                    widget.wardId = val;
                  });
                },
              )
          ),
        ],
      ),
    );
  }
}
