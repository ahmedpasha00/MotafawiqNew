import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepo(this.auth, this.firestore);

  // تسجيل دخول لمستخدم موجود
  Future<User> login(String email, String password) async {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Optional: تحقق لو المستخدم موجود في الـ Firestore
    final doc = await firestore.collection('users').doc(
        userCredential.user!.uid).get();
    if (!doc.exists) {
      throw Exception("هذا المستخدم غير موجود في قاعدة البيانات");
    }
    final role = doc['role'] ?? 'user';
    print('Role: $role'); // للتأكد في اللوج

    if (role == 'admin') {
      // لو أدمين، نرجع قيمة خاصة أو يمكن إضافة فئة جديدة
      return userCredential.user!; // أو نضيف خصائص خاصة للأدمين
    } else {
      return userCredential.user!;
    }
  }
}
