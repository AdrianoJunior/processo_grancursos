import 'package:flutter/material.dart';
import 'package:grancursos/api_response.dart';
import 'package:grancursos/pages/home/home_page.dart';
import 'package:grancursos/utils/alert.dart';
import 'package:grancursos/utils/nav.dart';
import 'package:grancursos/widgets/button_widget.dart';
import 'package:grancursos/widgets/header_container.dart';
import 'package:grancursos/widgets/text_input.dart';

import 'cadastro_page.dart';
import 'login_bloc.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();

  final _bloc = LoginBloc();

  final _focusSenha = FocusNode();

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
            Expanded(flex: 1, child: HeaderContainer("Login")),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextInput(
                      hint: "Email",
                      icon: Icons.email,
                      controller: _tLogin,
                      validator: (s) => _validateLogin(s),
                      keyboardType: TextInputType.emailAddress,
                      nextFocus: _focusSenha,
                      inputAction: TextInputAction.next,
                    ),
                    TextInput(
                      hint: "Senha",
                      icon: Icons.vpn_key,
                      controller: _tSenha,
                      validator: (s) => _validateSenha(s),
                      keyboardType: TextInputType.text,
                      focusNode: _focusSenha,
                      inputAction: TextInputAction.done,
                      password: true,
                    ),
                    Expanded(
                      child: Center(
                        child: StreamBuilder<bool>(
                            stream: _bloc.stream,
                            initialData: false,
                            builder: (context, snapshot) {
                              return ButtonWidget(
                                btnText: "LOGIN",
                                onClick: _onClickLogin,
                                showProgress: snapshot.data,
                              );
                            }),
                      ),
                    ),
                    InkWell(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "Não possui uma conta? ",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: "Registre-se",
                                style: TextStyle(color: Colors.pink)),
                          ],
                        ),
                      ),
                      onTap: () {
                        push(context, CadastroPage(), replace: true);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
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

  _onClickLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    ApiResponse userResponse =
        await _bloc.login(email: login, senha: senha);
    print("\n\n\nRESULT >>>>>>> ${userResponse.ok}\n\n\n");

    if (userResponse.ok!) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, userResponse.msg!);
    }
  }

  String? _validateSenha(String text) {
    if (text.isEmpty) {
      return "Por favor, digite a senha";
    } else if (text.length < 6) {
      return "A senha deve conter ao menos 6 caracteres";
    }
    return null;
  }

  String? _validateLogin(String text) {
    if (text.isEmpty) {
      return "Por favor, digite seu e-mail";
    }
    return null;
  }
}
