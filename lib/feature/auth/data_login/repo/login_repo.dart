import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepo {
  static loginWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String Confirmpassword,
    required String cuty,
    required String guardianPhone,
    required String phone,
    required String name,
  }) async {
    if (password != Confirmpassword) {
      throw FirebaseAuthException(
        code: 'password-mismatch',
        message: 'كلمة المرور و تأكيدها غير متطابقين',
      );
    }
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      final uid = credential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'email': emailAddress,
        'phone': phone,
        'guardianPhone': guardianPhone,
        'city': cuty,
        'Confirmpassword': Confirmpassword,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return credential;
    } on FirebaseAuthException catch (e) {
      // يفضل ترمي الخطأ إلى الـ Cubit بدل الطباعة فقط
      throw e;
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع');
    }
  }


  /// 🔹 Login (الجديد)
  static Future loginWithEmailAndPasswordOnly({
    required String emailAddress,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  }

}
