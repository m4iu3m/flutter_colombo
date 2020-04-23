import 'package:flutter/material.dart';
import 'form_select.dart';

class FormSelectRegionAddress extends StatefulWidget {
  final String domain;
  final Function onChangeProvince, onChangeDistrict, onChangeWard;
  final String errorProvince, errorDistrict, errorWard;
  final String labelProvince, labelDistrict, labelWard;
  final String provinceId, districtId, wardId;

  const FormSelectRegionAddress({
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
  String _provinceId, _districtId, _wardId;
  @override
  Widget build(BuildContext context) {
    _provinceId = _provinceId??widget.provinceId??null;
    _districtId = _districtId??widget.districtId??null;
    _wardId = _wardId??widget.wardId??null;
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
              value: _provinceId,
              showSearch: true,
              onChange: (val) {
                if(val != _provinceId) {
                  widget.onChangeProvince(val);
                  setState(() {
                    _provinceId = val;
                    _districtId = '';
                  });
                }
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
              extraParams: {'provinceId': _provinceId},
              value: _districtId,
              onChange: (val) {
                if(val != _districtId) {
                  widget.onChangeDistrict(val);
                  setState(() {
                    _districtId = val;
                  });
                }
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
                extraParams: {'districtId': _districtId},
                value: _wardId,
                onChange: (val) {
                  if(val != _wardId) {
                    widget.onChangeWard(val);
                    setState(() {
                      _wardId = val;
                    });
                  }
                },
              )
          ),
        ],
      ),
    );
  }
}
