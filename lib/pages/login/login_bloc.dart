import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:grancursos/api_response.dart';
import 'package:grancursos/firebase/firebase_service.dart';
import 'package:grancursos/pages/login/usuario.dart';
import 'package:grancursos/utils/simple_bloc.dart';

class LoginBloc extends SimpleBloc<bool> {
  final StreamController<bool> _streamController = StreamController<bool>();

  get stream => _streamController.stream;

  Future<ApiResponse<User>> login(
      {required String email, required String senha}) async {
    _streamController.add(true);

    ApiResponse<User> response = await FirebaseService().login(email, senha);

    _streamController.add(false);

    return response;
  }

  Future<ApiResponse<Usuario>> create(
      {required String email,
      required String senha,
      required String nome}) async {
    _streamController.add(true);

    ApiResponse<Usuario> response = await FirebaseService().create(
      email,
      senha,
      nome,
    );

    _streamController.add(false);

    return response;
  }

  void dispose() {
    _streamController.close();
  }
}
