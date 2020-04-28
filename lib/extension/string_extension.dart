import 'package:flutter/material.dart';
import '../widgets/helper/video_play.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

extension StringExtension on String {
  int parseInt() {
    return int.parse(this);
  }
  double parseDouble() {
    return double.parse(this);
  }
  bool isPhoneVN(){
    RegExp _regExp = new RegExp(
      r"^(0|\+?84)(9[0-9]|8[1-9]|7[0,6-9]|5[6,8,9]|3[2-9]|2\d{2})\d{7}$",
      caseSensitive: false,
      multiLine: false,
    );
    return _regExp.hasMatch(this);
  }
  bool isEmail(){
    RegExp _reExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
        caseSensitive: false,
        multiLine: false
    );
    return _reExp.hasMatch(this);
  }
  double ratio(){
    if(this != null && this != ''){
      RegExp _reExp = new RegExp(
          r"(\d+)\:(\d+)",
          caseSensitive: false,
          multiLine: false
      );
      final Iterable<Match> _matches = _reExp.allMatches(this.toString());
      for (Match m in _matches) {
        double _ratio = int.parse(m.group(1)) / int.parse(m.group(2));
        return _ratio;
      }
    }
    return 16/9;
  }



  String thumb(dynamic ratio, [double width, String domain]){
    final double _width = width??480;
    if(ratio is String){
      ratio = ratio.ratio();
    }else if(ratio is int){
      ratio = double.parse(ratio.toString());
    }
    if(ratio is double){
      if(this.indexOf('upload/') == 0){
        RegExp _reExp = new RegExp(
            r"(\d+)",
            caseSensitive: false,
            multiLine: false
        );
        final Match _matches = _reExp.firstMatch(this.toString());
        final String _site = _matches[0].toString();
        return '${domain??''}/publish/thumbnail/$_site/${_width.ceil()}x${(_width/ratio).ceil()}xdefault/$this';
      }
      return this;
    }
    return this;
  }
  bool notEmpty(){
    return (this != null && this.trim() != '');
  }
  Widget playVideo(){
    RegExp _reExpId = new RegExp(
        r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})',
        caseSensitive: false,
        multiLine: false
    );

    if(_reExpId.hasMatch(this)) {
      final Match match = _reExpId.firstMatch(this);
      if (match[1] != null && match[1].length > 10) {
        final String _image = 'https://i.ytimg.com/vi/${match[1]}/maxresdefault.jpg';
        return Container(
          child: InkWell(
            onTap: () {
              FlutterYoutube.playYoutubeVideoByUrl(
                  apiKey: "AIzaSyDvEii3etFTLNy4l6fU553jL1Wz3OLB4PM",
                  videoUrl: "https://www.youtube.com/watch?v=${match[1]}",
                  autoPlay: true
              );
            },
            child: AspectRatio(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Color(0xffeaeaea),
                  ),
                  Image.network(
                    _image, fit: BoxFit.cover, height: double.infinity,),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            width: 5),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 5,
                              color: Color.fromRGBO(0, 0, 0, 0.1)
                          )
                        ],
                      ),
                      child: Icon(Icons.play_circle_filled, size: 50,
                          color: Color.fromRGBO(255, 255, 255, 0.7))
                  )
                ],
                alignment: Alignment.center,
              ),
              aspectRatio: 1.5,
            ),
          ),
        );
      }
    }
    return Container(
      child: VideoPlay(this),
    );
  }
}