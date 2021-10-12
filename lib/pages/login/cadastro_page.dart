import 'package:flutter/material.dart';
import 'package:grancursos/api_response.dart';
import 'package:grancursos/pages/home/home_page.dart';
import 'package:grancursos/pages/login/usuario.dart';
import 'package:grancursos/utils/alert.dart';
import 'package:grancursos/utils/nav.dart';
import 'package:grancursos/widgets/button_widget.dart';
import 'package:grancursos/widgets/header_container.dart';
import 'package:grancursos/widgets/text_input.dart';

import 'login_bloc.dart';
import 'login_page.dart';

class CadastroPage extends StatefulWidget {

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _tNome = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _bloc = LoginBloc();

  final _focusEmail = FocusNode();
  final _focusSenha = FocusNode();

  final _focusData = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Registre-se"),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextInput(
                      hint: "Nome",
                      icon: Icons.person,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: (s) => _validateNome(s),
                      controller: _tNome,
                      nextFocus: _focusEmail,
                    ),
                    TextInput(
                      hint: "E-mail",
                      icon: Icons.email,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (s) => _validateLogin(s),
                      controller: _tLogin,
                      nextFocus: _focusSenha,
                      focusNode: _focusEmail,
                    ),
                    // _textInput(hint: "Phone Number", icon: Icons.call),
                    TextInput(
                      hint: "Senha",
                      icon: Icons.vpn_key,
                      inputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      validator: (s) => _validateSenha(s),
                      controller: _tSenha,
                      focusNode: _focusSenha,
                      nextFocus: _focusData,
                      password: true,
                    ),
                    Expanded(
                      child: Center(
                        child: StreamBuilder<bool>(
                            stream: _bloc.stream,
                            initialData: false,
                            builder: (context, snapshot) {
                              return ButtonWidget(
                                btnText: "REGISTRE-SE",
                                onClick: _onClickCadastro,
                                showProgress: snapshot.data,
                              );
                            }),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        push(context, LoginPage(), replace: true);
                      },
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "Já possui uma conta? ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Faça login",
                              style: TextStyle(color: Colors.pink)),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                push(context, HomePage(), replace: true);
              },
              child: const Center(
                child: Text("Continuar sem uma conta"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onClickCadastro() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String email = _tLogin.text;
    String senha = _tSenha.text;
    String nome = _tNome.text;
    Usuario user = Usuario(
      email: email,
      nome: nome,
    );

    ApiResponse createResponse =
        await _bloc.create(email: email, senha: senha, nome: nome);
    if (createResponse.ok!) {
      ApiResponse loginResponse = await _bloc.login(email: email, senha: senha);
      if (loginResponse.ok!) {
        Usuario().save();
        push(context, HomePage(), replace: true);
      } else {
        alert(context,
            "Não foi possível entrar, volte para a tela de login e tente novamente!",
            callback: () {
          push(context, LoginPage(), replace: true);
        });
      }
    } else {
      alert(
          context,
          createResponse.msg ??
              "Não foi possível criar sua conta, tente novamente");
    }
  }

  String? _validateLogin(text) {
    if (text.isEmpty) {
      return "Digite seu e-mail";
    }
    return null;
  }

  String? _validateSenha(text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    return null;
  }

  String? _validateNome(String text) {
    if (text.isEmpty) {
      return "Digite o seu nome";
    }
    return null;
  }
}
