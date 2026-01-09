import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../data_login/repo/login_repo.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Login({
    required String emailAddress,
    required String password,
    //هانشيل ال كونفيرم باسوردد
    required String confirmPassword,
    required String name,
    required String phone,
    required String guardianPhone,
    required String city,
    required String PublicOrAlAzhar,
    required String WhichGrade, // 👈 أضف ده

  }) async {
    if (emailAddress.isEmpty || password.isEmpty) {
      emit(LoginError(message: "Email and password cannot be empty"));
      return;
    }

    emit(LoginLoading());

    try {
      final credential = await LoginRepo.loginWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
        Confirmpassword: confirmPassword,
        name: name,
        phone: phone,
        guardianPhone: guardianPhone,
        cuty: city,
        WhichGrade: WhichGrade, // ✅ صح
        PublicOrAlAzhar: PublicOrAlAzhar,
      );


     final uid = credential.user!.uid;
     final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
     final role = userDoc['role']??'user';


      print('Role: $role');


      if (role == 'admin') {
        emit(LoginSuccessAdmin());
      } else {
        emit(LoginSuccessUser());
      }    } on FirebaseAuthException catch (e) {
      emit(LoginError(message: e.message ?? 'حدث خطأ في تسجيل الدخول'));
    } catch (e) {
      emit(LoginError(message: 'حدث خطأ غير متوقع'));
    }
  }

}
