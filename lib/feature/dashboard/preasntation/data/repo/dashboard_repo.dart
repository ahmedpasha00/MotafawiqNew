


import 'package:al_motafawiq/core/model/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  DashboardRepo(this.firestore, this.auth);

  Future<StudentModel> getStudentData() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) {
      throw Exception("User not logged in");
    }

    final doc = await firestore.collection('users').doc(uid).get();

    if (!doc.exists || doc.data() == null) {
      throw Exception("No data found for user $uid");
    }

    return StudentModel.fromMap(doc.data()!);
  }
}
