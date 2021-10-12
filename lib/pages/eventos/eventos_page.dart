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
  String loripsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
      " Proin pellentesque rhoncus lacinia. In accumsan laoreet"
      " magna nec luctus. Vivamus at gravida mauris. Ut facilisis"
      " diam sed vulputate fringilla. Morbi pharetra, sem non"
      " fermentum placerat, risus enim dapibus nunc, in mollis"
      " felis nisl vitae urna. Pellentesque et ex magna."
      " Aliquam id."
      " Proin pellentesque rhoncus lacinia. In accumsan laoreet"
      " magna nec luctus. Vivamus at gravida mauris. Ut facilisis"
      " diam sed vulputate fringilla. Morbi pharetra, sem non"
      " fermentum placerat, risus enim dapibus nunc, in mollis"
      " felis nisl vitae urna. Pellentesque et ex magna."
      " Aliquam id.";

  List<String> fotos = [
    "https://firebasestorage.googleapis.com/v0/b/grancursos-9ede7.appspot.com/o/defaults%2F04.jpeg?alt=media&token=dfe7943b-c427-4746-8765-8c264b128cc4",
    "https://firebasestorage.googleapis.com/v0/b/grancursos-9ede7.appspot.com/o/defaults%2F05.jpg?alt=media&token=b18d964a-2e39-4988-bf32-f673910d1bdd",
  ];

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

/*_body() {
    return Container(
      child: Center(
        child: user != null
            ? EventosListView(eventos: eventos)
            : TextError(
                "O conteúdo da página de eventos só está disponível"
                " para usuários conectados",
              ),
      ),
    );
  }*/
}

/*
/// A single movie row.
class _MovieItem extends StatelessWidget {
  _MovieItem(this.movie, this.reference);

  final Movie movie;
  final DocumentReference<Movie> reference;

  /// Returns the movie poster.
  Widget get poster {
    return SizedBox(
      width: 100,
      child: Center(
        child: Image.network(movie.poster),
      ),
    );
  }

  /// Returns movie details.
  Widget get details {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          metadata,
          genres,
        ],
      ),
    );
  }

  /// Return the movie title.
  Widget get title {
    return Text(
      '${movie.title} (${movie.year})',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  /// Returns metadata about the movie.
  Widget get metadata {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text('Rated: ${movie.rated}'),
          ),
          Text('Runtime: ${movie.runtime}'),
        ],
      ),
    );
  }

  /// Returns a list of genre movie tags.
  List<Widget> get genreItems {
    return [
      for (final genre in movie.genre)
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Chip(
            backgroundColor: Colors.lightBlue,
            label: Text(
              genre,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
    ];
  }

  /// Returns all genres.
  Widget get genres {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        children: genreItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Row(
        children: [
          poster,
          Flexible(child: details),
        ],
      ),
    );
  }
}
*/
