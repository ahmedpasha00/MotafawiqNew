import 'package:cloud_firestore/cloud_firestore.dart';

class TotalStudentsRepo {
  final FirebaseFirestore firestore;

  TotalStudentsRepo({required this.firestore});


  Future<int> getTotalStudents()async{
    try{

      final snapshot = await firestore.collection('users').get();
      return snapshot.docs.length;
    }catch(e){
      print("Error fetching students: $e");
      return 0;

    }
  }
}