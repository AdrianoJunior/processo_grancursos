import 'dart:convert' as convert;

import 'package:cloud_firestore/cloud_firestore.dart';

class Noticia {
  String? title;
  String? text;
  String? photoUrl;
  Timestamp? postDate;

  Noticia({this.title, this.text, this.photoUrl, this.postDate});

  Noticia.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    text = map['text'];
    photoUrl = map['photoUrl'];
    postDate = map['postDate'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    data['photoUrl'] = this.photoUrl;
    data['postDate'] = this.postDate;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }


}
