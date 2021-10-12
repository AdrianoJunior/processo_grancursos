import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grancursos/pages/splash/splash_page.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste Gran Cursos',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Color(0xFFf6f5ee),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}