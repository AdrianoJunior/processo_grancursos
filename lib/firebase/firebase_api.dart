import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grancursos/api_response.dart';
import 'package:grancursos/pages/login/usuario.dart';

class FirebaseApi {
  static Future<String> createUser(Usuario usuario) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    usuario.id = docUser.id;

    await docUser.set(usuario.toMap());

    return docUser.id;
  }

  static Future<ApiResponse?> updateUser(Usuario usuario) async {
    final docUser =
    FirebaseFirestore.instance.collection('users').doc(usuario.id);

    await docUser.update(usuario.toMap()).then((value) {
      return ApiResponse.ok();
    }).onError((error, stackTrace) {
      return ApiResponse.error(msg: "Não foi possível atualizar os seus dados");
    });
  }

  static Future deleteUser(Usuario usuario) async {
    final docUser =
    FirebaseFirestore.instance.collection('users').doc(usuario.id);
    await docUser.delete();
  }
}
