import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'bookings_page_event.dart';
part 'bookings_page_state.dart';

class BookingsPageBloc extends Bloc<BookingsPageEvent, BookingsPageState> {
  BookingsPageBloc() : super(BookingsPageInitial()) {
    on<BookingSubmitEvent>(_submit);
  }

  void _submit(BookingSubmitEvent event, emit) async {
    try {
      final newBooking = <String, String>{
        "patient_name": event.name,
        "patient_number": event.number,
        "patient_age": event.age.toString(),
        "patient_location": event.location,
        "patient_gender": event.gender,
        "patient_problem": event.problem,
        "patient_history": event.history
      };
      await FirebaseFirestore.instance.collection('bookings').add(newBooking);
      emit(BookingsPageSuccessState());
    } catch (e) {
      emit(BookingsPageFailedState(error: e.toString()));
    }
  }
}
