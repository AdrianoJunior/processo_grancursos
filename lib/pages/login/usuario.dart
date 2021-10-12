import 'dart:convert' as convert;

import 'package:grancursos/utils/prefs.dart';

class Usuario {
  String? nome;
  String? id;
  String? uid;
  String? email;
  String? photoUrl;

  Usuario({
    this.nome,
    this.id,
    this.email,
    this.uid,
    this.photoUrl,
  });

  static Usuario fromMap(Map<String, dynamic>? user) => Usuario(
        nome: user!['nome'],
        id: user['uid'],
        email: user['email'],
        uid: user['uid'],
        photoUrl: user['photoUrl'],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['id'] = this.id;
    data['email'] = this.email;
    data['uid'] = this.uid;
    data['photoUrl'] = this.photoUrl;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  void save() {
    // Map map = toMap();

    final Map<String, dynamic> userData = new Map<String, dynamic>();
    // userData['nome'] = this.nome;
    userData['uid'] = this.id;
    userData['email'] = this.email;

    String json = convert.json.encode(userData);
    Prefs.setString("user.prefs", json);
  }

  static Future<Usuario?> get() async {
    String json = await Prefs.getString("user.prefs");

    if (json.isEmpty) {
      return null;
    }
    Map<String, dynamic> map = convert.json.decode(json);

    Usuario user = Usuario.fromMap(map);

    return user;
  }

  @override
  String toString() {
    return 'Usuario{UID: $uid, id: $id, login: $email, nome: $nome, photoUrl: $photoUrl}';
  }
}
