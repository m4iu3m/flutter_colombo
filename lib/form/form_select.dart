import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smart_select/smart_select.dart';

// ignore: must_be_immutable
class FormSelect extends StatefulWidget {
  final String fileLocal;
  final String service;
  final Map<String, String> items;
  String value;
  final String errorText;
  final String labelText;
  final dynamic extraParams;
  final ValueChanged onChange;
  final SmartSelectModalType typePopup;
  final bool showSearch;
  final String searchBarHint;
  final InputDecoration decoration;
  final IconData icon;
  final String emptyDataText;
  FormSelect(
      {this.fileLocal,
        this.service,
        this.items,
        this.value,
        this.errorText,
        this.labelText,
        this.extraParams,
        this.onChange,
        this.typePopup,
        this.showSearch,
        this.searchBarHint,
        this.decoration,
        this.icon, this.emptyDataText});
  @override
  _FormSelectState createState() => _FormSelectState();
}

class _FormSelectState extends State<FormSelect> {
  final _dio = Dio();
  List<SmartSelectOption<String>> _items = [];
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
    return SmartSelect<String>.single(
        title: (widget.labelText != null) ? widget.labelText : '',
        value: widget.value,
        isTwoLine: false,
        options: _items,
        modalType: (widget.typePopup != null)
            ? widget.typePopup
            : SmartSelectModalType.bottomSheet,
        modalConfig: SmartSelectModalConfig(
          searchBarHint: (widget.searchBarHint != null)
              ? widget.searchBarHint
              : 'Tìm kiếm',
          useHeader: (widget.showSearch != null) ? widget.showSearch : false,
          useFilter: (widget.showSearch != null) ? widget.showSearch : false,
        ),
        choiceConfig: SmartSelectChoiceConfig(emptyBuilder: (String string) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search, size: 120.0, color: Colors.black12),
                  Container(height: 25),
                  Text(
                    widget.emptyDataText??'Không có dữ liệu',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .merge(TextStyle(color: Colors.black54)),
                  ),
                ],
              ),
            ),
          );
        }),
        builder: (context, state, showOption) {
          return InkWell(
            onTap: () => showOption(context),
            child: Stack(alignment: Alignment.centerRight, children: <Widget>[
              TextFormField(
                controller: TextEditingController()
                  ..text = state.valueTitle ?? null,
                enabled: false,
                maxLines: 1,
                decoration: widget.decoration ??
                    InputDecoration(
                        labelText: state.title,
                        errorText: widget.errorText,
                        border: UnderlineInputBorder(borderSide: BorderSide()),
                        contentPadding:
                        EdgeInsets.only(bottom: 2.0, right: 25)),
              ),
              Positioned(
                  right: 5,
                  child: Icon(
                    widget.icon ?? Icons.keyboard_arrow_down,
                    size: 18,
                  ))
            ]),
          );
        },
        isLoading: _usersIsLoading,
        onChange: (val) {
          widget.onChange(val);
          setState(() => widget.value = val);
        });
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
            : ((widget.extraParams != null) ? widget.extraParams : null);
        var _res;
        if (_body != null) {
          FormData formData = new FormData.fromMap(_body);
          _res = await _dio.post(widget.service, data: formData);
        } else {
          _res = await _dio.get(widget.service);
        }
        final _itemData = json.decode(_res.data)['items'];
        List<Map<String, String>> _resBody = [];
        if (_itemData is Map<String, dynamic>) {
          _itemData.forEach((key, value) {
            _resBody.add({
              'id': value['id'] ?? '',
              'title': value['title'] ?? value['label'] ?? '',
            });
          });
        } else if (_itemData is List) {
          _itemData.forEach((element) {
            _resBody.add({
              'id': element['id'] ?? '',
              'title': element['title'] ?? element['label'] ?? '',
            });
          });
        }
        List<SmartSelectOption> options =
        SmartSelectOption.listFrom<String, dynamic>(
          source: _resBody,
          value: (index, item) => item['id'].toString(),
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

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }
}
