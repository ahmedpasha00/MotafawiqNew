import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../data_login/repo/login_repo.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Login({
    required String emailAddress,
    required String password,
    required String confirmPassword,
    required String name,
    required String phone,
    required String guardianPhone,
    required String city,
  }) async {
    if (emailAddress.isEmpty || password.isEmpty) {
      emit(LoginError(message: "Email and password cannot be empty"));
      return;
    }

    emit(LoginLoading());

    try {
      await LoginRepo.loginWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
        Confirmpassword: confirmPassword,
        name: name,
        phone: phone,
        guardianPhone: guardianPhone,
        cuty: city,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginError(message: e.message ?? 'حدث خطأ في تسجيل الدخول'));
    } catch (e) {
      emit(LoginError(message: 'حدث خطأ غير متوقع'));
    }
  }

  LoginOnly({required String emailAddress, required String password}) async {
    emit(LoginLoading());

    try {
      await LoginRepo.loginWithEmailAndPasswordOnly(
        emailAddress: emailAddress,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'user-not-found':
          message = 'الإيميل غير مسجل';
          break;

        case 'wrong-password':
          message = 'كلمة المرور غير صحيحة';
          break;

        case 'invalid-email':
          message = 'الإيميل غير صالح';
          break;

        case 'user-disabled':
          message = 'هذا الحساب موقوف';
          break;

        case 'too-many-requests':
          message = 'محاولات كثيرة، حاول لاحقًا';
          break;

        default:
          message = 'حدث خطأ، حاول مرة أخرى';
      }
      emit(LoginError(message: message)); // ✅ هنا مهم
    } catch (e) {
      emit(LoginError(message: 'حدث خطأ غير متوقع'));
    }
  }
}
