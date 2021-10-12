import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  Future<bool?> checkExist(String docID) async {
    await FirebaseFirestore.instance.doc("users/$docID").get().then((doc) {
      return doc.exists;
    });
  }
}
