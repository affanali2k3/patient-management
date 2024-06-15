part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterSubmitEvent extends RegisterEvent {
  RegisterSubmitEvent(
      {required this.email,
      required this.password,
      required this.jobType,
      required this.name,
      this.speciality});
  final String email;
  final String password;
  final String name;
  final String jobType;
  final String? speciality;
}
