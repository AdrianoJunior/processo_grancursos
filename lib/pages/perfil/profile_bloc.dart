import 'dart:async';

import 'package:grancursos/api_response.dart';
import 'package:grancursos/firebase/firebase_service.dart';
import 'package:grancursos/utils/simple_bloc.dart';

class ProfileBloc extends SimpleBloc<bool> {
  Future<ApiResponse> updateProfile({required String name}) async {
    add(true);

    ApiResponse response = await FirebaseService.saveUserData(
      name: name,
    );

    add(false);

    return response;
  }
}
