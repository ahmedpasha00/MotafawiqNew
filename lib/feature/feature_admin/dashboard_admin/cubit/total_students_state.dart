part of 'total_students_cubit.dart';

@immutable
sealed class TotalStudentsState {}

final class TotalStudentsInitial extends TotalStudentsState {}

final class TotalStudentsLoading extends TotalStudentsState {}

final class TotalStudentsSuccess extends TotalStudentsState {
  final int totalStudents;
  TotalStudentsSuccess (this.totalStudents);
}

final class TotalStudentsError extends TotalStudentsState {
  final String message;
  TotalStudentsError(this.message);
}