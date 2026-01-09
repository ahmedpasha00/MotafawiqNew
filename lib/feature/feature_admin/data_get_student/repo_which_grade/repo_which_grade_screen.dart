import 'package:al_motafawiq/core/model/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RepoWhichGradeScreen {
  final FirebaseFirestore firestore;

  RepoWhichGradeScreen({required this.firestore});

  Stream<List<StudentModel>> getRepoWhichGrade(String grade) {
    return firestore
        .collection('users')
        .where('WhichGrade', isEqualTo: grade)
        .snapshots()
        .map(
          (snapshots) => snapshots.docs
              .map((doc) => StudentModel.fromMap(doc.data()))
              .toList(),
        );
  }
}
