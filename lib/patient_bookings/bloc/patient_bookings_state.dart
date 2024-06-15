part of 'patient_bookings_bloc.dart';

@immutable
sealed class PatientBookingsState {}

final class PatientBookingsInitial extends PatientBookingsState {}

final class PatientBookingsAcceptedState extends PatientBookingsState {}

final class PatientBookingsRejectedState extends PatientBookingsState {}
