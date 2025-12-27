part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


final class LoginSuccessAdmin extends LoginState {}
final class LoginSuccessUser extends LoginState {}
 final class LoginLoading extends LoginState {}
final class LoginError extends LoginState {
  final String? message; // <--- أضف هذا السطر
  LoginError({this.message});
}