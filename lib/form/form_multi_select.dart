import 'dart:convert';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FormMultiSelect extends StatefulWidget {
  final String fileLocal;
  final String service;
  final Map<String, String> items;
  final List<String> value;
  final String errorText;
  final String labelText;
  final dynamic extraParams;
  final ValueChanged onChange;
  final SmartSelectModalType typePopup;
  final bool showSearch;
  final String searchBarHint;
  final InputDecoration decoration;
  FormMultiSelect({
    this.fileLocal,
    this.service,
    this.items,
    this.value,
    this.errorText,
    this.labelText,
    this.extraParams,
    this.onChange,
    this.typePopup,
    this.showSearch,
    this.searchBarHint, this.decoration
  });
  @override
  _FormMultiSelectState createState() => _FormMultiSelectState();
}

class _FormMultiSelectState extends State<FormMultiSelect> {
  List<SmartSelectOption<String>> _items = [];
  List<String> _value = [];
  bool _usersIsLoading;
  var _extraParams;
  @override
  Widget build(BuildContext context) {
    if (widget.extraParams != null) {
      if (_extraParams != widget.extraParams) {
        _extraParams = widget.extraParams;
        _getData(extras: _extraParams);
      }
    }
    return SmartSelect<String>.multiple(
          title: (widget.labelText != null) ? widget.labelText : '',
          //value: (widget.value != null) ? widget.value : _value,
          value: _value,
          isTwoLine: false,
          options: _items,
          modalType: (widget.typePopup != null)?widget.typePopup:SmartSelectModalType.bottomSheet,
          modalConfig: SmartSelectModalConfig(
            searchBarHint: (widget.searchBarHint != null)?widget.searchBarHint:'Tìm kiếm',
            useHeader: (widget.showSearch != null)?widget.showSearch:false,
            useFilter: (widget.showSearch != null)?widget.showSearch:false
          ),
          builder: (context, state, showOption) {
            print(state.values);
            return InkWell(
              child: InputDecorator(
                decoration: widget.decoration ??
                _inputDecoration(
                    hintText: widget.labelText,
                    errorText: widget.errorText
                ),
                child: Row(
                  children: <Widget>[
                    (state.values.length > 2)?
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xffcccccc)
                      ),
                      child: Text('${(state.values.length > 10)?state.values.length.toString()+'+':state.values.length}'),
                    ):Container(),
                    Expanded(
                      flex: 1,
                      child: Text(
                        (state.values.length > 0)
                            ? state.valueDisplay
                            : state.title,
                        //state.valueDisplay,
                        style: TextStyle(
                          fontSize:
                          (fontSizeBase != null) ? fontSizeBase : 14.0,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            onTap: () => showOption(context),
          );
        },
        isLoading: _usersIsLoading,
        onChange: (val) {
          (widget.onChange != null)
              ? widget.onChange(val)
              : setState(() => _value = val);
        }
    );
  }
  InputDecoration _inputDecoration({String hintText, String errorText}){
    return InputDecoration(
      hintText: hintText,
      errorText: errorText,
      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Color(0xFFCCCCCC), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.blue, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
    );
  }
  @override
  initState() {
    super.initState();
    _getData();
  }

  void _getData({extras}) async {
    try {
      setState(() => _usersIsLoading = true);
      if (widget.service != null) {
        final _body = (extras != null)
            ? extras
            : ((widget.extraParams != null) ? widget.extraParams : {});
        final res = await http.post(Uri.encodeFull(widget.service),
            body: _body, headers: {"Accept": "application/json"});
        final _itemData = json.decode(res.body)['items'];
        List<Map<String, String>> _resBody = [];
        if(_itemData is Map<String, dynamic>){
          _itemData.forEach((key, value) {
            _resBody.add({
              'id': value['id']??'',
              'title': value['title']??value['label']??'',
            });
          });
        }else{
          _resBody = _itemData;
        }
        List<SmartSelectOption> options =
        SmartSelectOption.listFrom<String, dynamic>(
          source: _resBody,
          value: (index, item) => item['id'],
          title: (index, item) => item['title'],
        );
        setState(() => _items = options);
      } else {
        if (widget.items != null) {
          List<Map<String, String>> _resBody = [];
          widget.items.forEach((k, v) {
            if (k != '') {
              _resBody.add({
                'id': (k != null) ? k.toString() : '',
                'title': (v != null) ? v.toString() : ''
              });
            }
          });
          List<SmartSelectOption> options =
          SmartSelectOption.listFrom<String, dynamic>(
            source: _resBody,
            value: (index, item) => item['id'],
            title: (index, item) => item['title'],
          );
          setState(() {
            _items = options;
          });
        }
      }
    } catch (e) {
      print(e);
    } finally {
      _usersIsLoading = false;
    }
  }
}
