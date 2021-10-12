import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grancursos/pages/home/noticia.dart';

class NoticiasService {
  CollectionReference get _eventos =>
      FirebaseFirestore.instance.collection("noticias").withConverter<Noticia>(
        fromFirestore: (snapshots, _) => Noticia.fromMap(snapshots.data()!),
        toFirestore: (noticia, _) => noticia.toMap(),
      );

  Stream<QuerySnapshot> get stream => _eventos.orderBy('postDate').snapshots();
}
