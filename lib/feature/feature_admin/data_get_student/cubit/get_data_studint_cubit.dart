import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/model/student_model.dart';
import '../repo_which_grade/repo_which_grade_screen.dart';

part 'get_data_studint_state.dart';

class GetDataStudintCubit extends Cubit<GetDataStudintState> {
  final RepoWhichGradeScreen repo;
  GetDataStudintCubit({required this.repo}) : super(GetDataStudintInitial());

  void loadStudint(String grade){
    emit(StudentsLoading());
    try{
      repo.getRepoWhichGrade(grade).listen((studentsList) {
        emit(StudentsSuccess(studentsList));
      });
    }catch(e){
      emit(StudentsError(e.toString()));

    }
  }
}
