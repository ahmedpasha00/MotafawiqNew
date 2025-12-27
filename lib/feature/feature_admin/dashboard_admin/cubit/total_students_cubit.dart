import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/repo/total_students_repo.dart';

part 'total_students_state.dart';

class TotalStudentsCubit extends Cubit<TotalStudentsState> {
  final TotalStudentsRepo repository;

  TotalStudentsCubit({required this.repository}) : super(TotalStudentsInitial());



  Future<void> fetchTotalStudents() async {
    emit(TotalStudentsLoading());
    try {
      final total = await repository.getTotalStudents();
      emit(TotalStudentsSuccess(total));
    } catch (e) {
      emit(TotalStudentsError(e.toString()));
    }
  }
}
