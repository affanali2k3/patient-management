part of 'bookings_page_bloc.dart';

@immutable
sealed class BookingsPageState {}

final class BookingsPageInitial extends BookingsPageState {}

final class BookingsPageSuccessState extends BookingsPageState {}

final class BookingsPageFailedState extends BookingsPageState {
  BookingsPageFailedState({required this.error});
  final String error;
}
