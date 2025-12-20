// import 'package:al_motafawiq/feature/auth/data/repo/auth_repo.dart';
// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:meta/meta.dart';
//
// part 'auth_state.dart';
//
// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());
//
//   // login({required String emailAddress, required String password}) async {
//   //   emit(AuthLoading());
//   //
//   //   try {
//   //     await AuthRepo.loginWithEmailAndPassword(
//   //       emailAddress: emailAddress,
//   //       password: password,
//   //     );
//   //     emit(AuthSuccess());
//   //   } on FirebaseAuthException catch (e) {
//   //     if (e.code == 'email-already-in-use') {
//   //       print('الحساب موجود بالفعل. حاول تسجيل الدخول.');
//   //       emit(AuthError (message: e.message ?? 'حدث خطأ في تسجيل الدخول') );
//   //     } else {
//   //       emit(AuthError (message: e.message ?? 'حدث خطأ في تسجيل الدخول'));
//   //     }
//   //   }
//   //   catch (e) {
//   //     emit(AuthError());
//   //   }
//   // }
// }
