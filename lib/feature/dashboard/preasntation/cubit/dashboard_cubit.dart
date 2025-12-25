import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/model/student_model.dart';
import '../data/repo/dashboard_repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepo repo;

  DashboardCubit(this.repo) : super(DashboardInitial());


  Future<void> getStudentData()async{
    emit(DashboardLoading());
    try{
      final student = await repo.getStudentData();
      emit(DashboardSuccess(student));
    }catch (e) {
      print('Dashboard Error: $e');
      emit(DashboardError(e.toString()));
    }
  }
}
