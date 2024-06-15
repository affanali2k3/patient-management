import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'patient_bookings_event.dart';
part 'patient_bookings_state.dart';

class PatientBookingsBloc
    extends Bloc<PatientBookingsEvent, PatientBookingsState> {
  PatientBookingsBloc() : super(PatientBookingsInitial()) {
    on<PatientBookingsAcceptEvent>(_accept);
    on<PatientBookingsRejectEvent>(_reject);
  }
  void _accept(PatientBookingsAcceptEvent event, emit) async {
    final docData = {
      "patient_name": event.pendingRequests['patient_name'],
      "patient_problem": event.pendingRequests['patient_problem'],
      "patient_number": event.pendingRequests['patient_number'],
      "patient_gender": event.pendingRequests['patient_gender'],
      "patient_location": event.pendingRequests['patient_location'],
      "patient_age": event.pendingRequests['patient_age'],
      "patient_history": event.pendingRequests['patient_history'],
      "receptionist": event.receptionist,
      "speciality": event.speciality,
    };

    await FirebaseFirestore.instance
        .collection('requests_pending')
        .add(docData);
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(event.pendingRequests.id)
        .delete();

    emit(PatientBookingsAcceptedState());
  }

  void _reject(PatientBookingsRejectEvent event, emit) async {
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(event.id)
        .delete();
  }
}
