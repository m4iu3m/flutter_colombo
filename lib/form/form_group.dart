import 'package:flutter/material.dart';
import '../global.dart';
class FormGroup extends StatelessWidget{
  final String title;
  final Widget child;
  final String errorText;
  final bool required;
  final String note;
  final bool notBold;

  const FormGroup(this.title,{
    this.required: false,
    this.errorText: '',
    this.child, this.note, this.notBold: false,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _label(context),
          _errorText(),
          this.child,
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
  Widget _errorText(){
    if(errorText != null && errorText != ''){
      return Column(
        children: <Widget>[
          SizedBox(height: 5,),
          Semantics(
            container: true,
            liveRegion: true,
            child: Text(
              errorText,
              style: TextStyle(fontSize: 12, color: ThemeData.light().errorColor),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(height: 5,),
        ],
      );
    }else{
      return SizedBox(height: 5,);
    }
  }
  Widget _label(BuildContext context){
    if(required == true){
      return RichText(
        text: TextSpan(
            text: this.title,
            style: Theme.of(context).textTheme.bodyText1,
            children: <TextSpan>[
              TextSpan(
                text: ' (*)',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.red
                ),
              )
            ]
        ),
      );
    }else{
      return Text(
        this.title.toString(),
        style: TextStyle(
            fontWeight: (notBold == false)?FontWeight.w500:FontWeight.normal,
            color: Colors.black87
        ),
      );
    }
  }
}