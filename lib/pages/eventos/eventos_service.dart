import 'package:cloud_firestore/cloud_firestore.dart';

import 'evento.dart';

class EventosService {
  CollectionReference get _eventos =>
      FirebaseFirestore.instance.collection("eventos").withConverter<Evento>(
            fromFirestore: (snapshots, _) => Evento.fromMap(snapshots.data()!),
            toFirestore: (evento, _) => evento.toMap(),
          );

  Stream<QuerySnapshot> get stream => _eventos.orderBy('eventDate').snapshots();
}
