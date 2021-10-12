import 'package:flutter/material.dart';
import 'package:grancursos/pages/home/noticias_list_view.dart';
import 'package:grancursos/pages/home/noticias_service.dart';
import 'package:grancursos/widgets/drawer_list.dart';
import 'package:grancursos/widgets/text_error.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notícias"),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: StreamBuilder(
        stream: NoticiasService().stream,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextError('Não foi possível recuperar as notícias.'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return NoticiasListView(data: data);
        },
      ),
    );
  }
}
