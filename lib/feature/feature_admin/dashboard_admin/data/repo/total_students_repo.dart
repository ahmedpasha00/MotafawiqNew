import 'package:cloud_firestore/cloud_firestore.dart';

class TotalStudentsRepo {
  final FirebaseFirestore firestore;

  TotalStudentsRepo({required this.firestore});

  Stream<int> getTotalStudentsStream() {
    return firestore.collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
  }
