part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterSuccessState extends RegisterState {}

final class RegisterFailedState extends RegisterState {
  RegisterFailedState({required this.error});
  final String error;
}
