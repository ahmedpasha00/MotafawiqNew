import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../data_register/repo_register/repo_register.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo repo;

  RegisterCubit(this.repo) : super(RegisterInitial());


  Future<void> loginUser(String email, String password) async {
    emit(RegisterLoading());

    try {
      final user = await repo.login(email, password);
      final doc = await repo.firestore.collection('users').doc(user.uid).get();
      final role = doc['role'] ?? 'user';

      if (role == 'admin') {
        emit(RegisterSuccessAdmin(user));
      } else {
        emit(RegisterSuccess(user));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
