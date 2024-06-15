part of 'patient_bookings_bloc.dart';

@immutable
sealed class PatientBookingsEvent {}

final class PatientBookingsAcceptEvent extends PatientBookingsEvent {
  PatientBookingsAcceptEvent(
      {required this.pendingRequests,
      required this.receptionist,
      required this.speciality});
  final QueryDocumentSnapshot<Object?> pendingRequests;
  final String? receptionist;
  final String speciality;
}

final class PatientBookingsRejectEvent extends PatientBookingsEvent {
  PatientBookingsRejectEvent({required this.id});
  final String id;
}
