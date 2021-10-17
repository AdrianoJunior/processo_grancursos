import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grancursos/pages/eventos/eventos_list_view.dart';
import 'package:grancursos/pages/eventos/eventos_service.dart';
import 'package:grancursos/widgets/drawer_list.dart';
import 'package:grancursos/widgets/text_error.dart';

import 'evento.dart';

class EventosPage extends StatefulWidget {
  @override
  _EventosPageState createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  List<Evento>? eventos;
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
        title: Text("Eventos"),
      ),
      drawer: DrawerList(),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: StreamBuilder(
        stream: EventosService().stream,
        builder: (BuildContext context, snapshot) {
          if (user == null) {
            return TextError(
              "Os eventos só estão disponíveis para usuários conectados no app!",
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: TextError('Não foi possível recuperar os eventos.'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.requireData;

            return EventosListView(data: data);
          }
        },
      ),
    );
  }
}
