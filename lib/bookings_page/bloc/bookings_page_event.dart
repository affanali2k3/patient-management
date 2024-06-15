part of 'bookings_page_bloc.dart';

@immutable
sealed class BookingsPageEvent {}

final class BookingSubmitEvent extends BookingsPageEvent {
  BookingSubmitEvent(
      {required this.age,
      required this.name,
      required this.gender,
      required this.history,
      required this.location,
      required this.number,
      required this.problem});
  final String name;
  final String number;
  final String age;
  final String location;
  final String gender;
  final String problem;
  final String history;
}
