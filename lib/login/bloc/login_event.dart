part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginSubmitEvent extends LoginEvent {
  LoginSubmitEvent({required this.email, required this.password});
  final String email;
  final String password;
}
