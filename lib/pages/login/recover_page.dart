import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grancursos/utils/alert.dart';
import 'package:grancursos/widgets/button_widget.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({Key? key}) : super(key: key);

  @override
  _RecoverPageState createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  User? user;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trocar Senha"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          const Text(
            "Ao clicar no botão abaixo será enviado um link para o e-mail cadastrado no aplicativo para redefinir sua senha.",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
            // maxLines: 3,
          ),
          const SizedBox(height: 32),
          ButtonWidget(
            btnText: "Redefinir senha",
            onClick: _sendPasswordReset,
          ),
        ],
      ),
    );
  }

  _sendPasswordReset() {
    if (user != null) {
      String email;
      email = user!.email!;
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then(
            (value) => alert(
          context,
          "Um link para redefinição de senha foi enviado para o e-mail: $email",
        ),
      )
          .onError((error, stackTrace) {
        alertCancel(
          context,
          "Não foi possível enviar o email para a redefinição de senha.\nPor favor, tente novamente!",
          callback: _sendPasswordReset,
        );
      });
    }
  }
}
