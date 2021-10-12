import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grancursos/api_response.dart';
import 'package:grancursos/pages/login/usuario.dart';
import 'package:path/path.dart' as path;

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse<User>> login(String email, String senha) async {
    try {
      // Usuario do Firebase
      final authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: senha);
      final User? fUser = authResult.user;
      print("signed in ${authResult.user!.displayName}");

      // Cria um usuario do app
      final user = Usuario(
        nome: fUser!.displayName ?? "",
        email: fUser.email,
        uid: fUser.uid,
        photoUrl: fUser.photoURL ?? "",
      );
      user.save();

      // Resposta genérica

      if (user != null) {
        return ApiResponse.ok(
            /*result: true, msg: "Login efetuado com sucesso"*/);
      } else {
        return ApiResponse.error(
            msg: "Não foi possível fazer o login, tente novamente!");
      }
    } on FirebaseAuthException catch (e) {
      print(" >>> CODE : ${e.code}\n>>> ERRO : $e");
      return ApiResponse.error(
          msg: "Não foi possível fazer o login, tente novamente!");
    }
  }

  Future<ApiResponse<Usuario>> create(
      String email, String senha, String name) async {
    try {
      // Usuario do Firebase
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      final User? fUser = authResult.user;
      print("created user ${authResult.user!.displayName}");

      fUser!.updateDisplayName(name);

      // Cria um usuario do app
      final user = Usuario(
          nome: fUser.displayName ?? "",
          email: fUser.email,
          uid: fUser.uid,
          photoUrl: fUser.photoURL ?? "");
      // user.save();

      if (user != null) {
        return ApiResponse.ok(result: user);
      } else {
        return ApiResponse.error(
            msg: "Não foi possível criar sua conta, tente novamente!");
      }
    } on FirebaseAuthException catch (e) {
      print(" >>> CODE : ${e.code}\n>>> ERRO : $e");

      if (e.code == 'email-already-in-use') {
        return ApiResponse.error(
            msg: 'Já existe um usuário cadastrado com este e-mail.');
      } else {
        return ApiResponse.error(
            msg: "Não foi possível criar sua conta, tente novamente!");
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Usuario.clear();
  }

  static Future<ApiResponse<String>> uploadFirebaseStorage(
      File? file, String uid) async {
    try {
      String fileName = path.basename(file!.path);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(uid)
          .child(fileName);
      late String downloadUrl;
      final task = await storageRef.putFile(file).then((result) async {
        downloadUrl = await result.ref.getDownloadURL();
      });

      if (downloadUrl != null && downloadUrl.isNotEmpty)
        print("downloadURL >>>>>> $downloadUrl");

      return ApiResponse.ok(result: downloadUrl);
    } catch (e) {
      print("UPLOAD ERROR >>>>>> $e");
      return ApiResponse.error();
    }
  }

  static Future<ApiResponse<bool>> saveUserData({
    required String name,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      user!.updateDisplayName(name);
      return ApiResponse.ok();
    } catch (e) {
      return ApiResponse.error();
    }
  }
}
