part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccessState extends LoginState {
  LoginSuccessState({required this.userData, required this.userType});
  final Map<String, String> userData;
  final String userType;
}

final class LoginFailedState extends LoginState {
  LoginFailedState({required this.error});
  final String error;
}
