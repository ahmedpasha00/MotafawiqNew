part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}
final class DashboardSuccess extends DashboardState {
  final StudentModel student;

  DashboardSuccess(this.student);

}
final class DashboardLoading  extends DashboardState {}
final class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);

}
