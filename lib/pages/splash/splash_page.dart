import 'package:flutter/material.dart';
import 'package:grancursos/pages/home/home_page.dart';
import 'package:grancursos/pages/login/login_page.dart';
import 'package:grancursos/pages/login/usuario.dart';
import 'package:grancursos/utils/nav.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future futureDelay = Future.delayed(Duration(seconds: 3));

    Future futureUser = Usuario.get();

    Future.wait([futureDelay, futureUser]).then((List values) {
      push(context, HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/logo.png'),
          ),
          // SizedBox(height: 32),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
