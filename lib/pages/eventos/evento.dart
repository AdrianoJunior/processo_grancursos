import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert' as convert;

class Evento {
  String? name;
  String? desc;
  String? photoUrl;
  Timestamp? eventDate;

  Evento({this.name, this.desc, this.photoUrl, this.eventDate});

  Evento.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    desc = map['desc'];
    photoUrl = map['photoUrl'];
    eventDate = map['eventDate'];
  }

  Map<String, Object?> toMap() {
    /*final Map<String, Object?> data = new Map<String, Object?>();
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['photoUrl'] = this.photoUrl;
    data['eventDate'] = this.eventDate;
    return data;*/

    return {
      'name': name,
      'desc': desc,
      'photoUrl': photoUrl,
      'eventDate': eventDate,
    };


  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  @override
  String toString() {
    return 'Evento{nome: $name, descricao: $desc, urlFoto: $photoUrl, eventDate: ${eventDate!.toDate()}';
  }
}