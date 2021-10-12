import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:grancursos/api_response.dart';
import 'package:grancursos/pages/home/home_page.dart';
import 'package:grancursos/pages/login/usuario.dart';
import 'package:grancursos/pages/perfil/profile_service.dart';
import 'package:grancursos/utils/alert.dart';
import 'package:grancursos/utils/nav.dart';
import 'package:grancursos/widgets/button_widget.dart';
import 'package:grancursos/widgets/drawer_list.dart';
import 'package:grancursos/widgets/text_input.dart';

import 'profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final _tName = TextEditingController();

  String? urlFoto;
  late FirebaseFirestore _firestore;

  final _formKey = GlobalKey<FormState>();

  var userData;

  final _bloc = ProfileBloc();

  ProfileService profileService = ProfileService();
  bool? exists;

  late String uid;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;

    _firestore = FirebaseFirestore.instance;

    if (user != null) {
      _tName.text = user.displayName ?? "";
      urlFoto = user.photoURL;
      uid = user.uid;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextInput(
                  hint: "Nome",
                  controller: _tName,
                  inputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  validator: (s) => _validateName(s),
                  icon: FontAwesome.pencil,
                ),
              ),
              const SizedBox(height: 24),
              StreamBuilder<bool>(
                stream: _bloc.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      child: ButtonWidget(
                        btnText: "Salvar",
                        onClick: _onClickSalvar,
                        showProgress: snapshot.data,
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _onClickSalvar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Usuario usuario = Usuario();
    _upLoadUserData(usuario);
  }

  void _upLoadUserData(Usuario usuario) async {
    try {
      usuario.nome = _tName.text;
      usuario.email = FirebaseAuth.instance.currentUser!.email;

      ApiResponse saveResponse = await _bloc.updateProfile(
        name: usuario.nome!,
      );
      if (saveResponse.ok!) {
        usuario.save();
        alert(context, "Dados salvos com sucesso", callback: () {
          Future.delayed(Duration(seconds: 3)).then((value) {
            push(context, HomePage(), replace: true);
          });
        });
      } else {
        alert(context, "Não foi possível salvar os dados, tente novamente");
      }
    } catch (e) {
      alert(context, "Não foi possível salvar os dados, tente novamente");
    }
  }

  String? _validateName(String text) {
    if (text.isEmpty || text == null) {
      return "Digite seu nome";
    } else if (text.length < 3) {
      return "Seu nome deve ter pelo menos 3 caracteres";
    }
    return null;
  }
}
