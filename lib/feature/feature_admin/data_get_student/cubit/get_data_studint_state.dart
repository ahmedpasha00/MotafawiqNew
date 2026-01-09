part of 'get_data_studint_cubit.dart';

@immutable
sealed class GetDataStudintState {}

final class GetDataStudintInitial extends GetDataStudintState {}



class StudentsLoading extends GetDataStudintState {}
class StudentsSuccess extends GetDataStudintState {
  final List<StudentModel> students;
  StudentsSuccess(this.students);
}
class StudentsError extends GetDataStudintState {
  final String message;
  StudentsError(this.message);
}

