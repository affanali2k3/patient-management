import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitEvent>(_register);
  }

  void _register(RegisterSubmitEvent event, emit) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email, password: event.password);

      final user = <String, String>{
        "name": event.name,
        "email": event.email,
        "job_type": event.jobType,
      };

      if (event.jobType == 'Doctor') {
        user['speciality'] = event.speciality!;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(event.email)
          .set(user);

      emit(RegisterSuccessState());
    } catch (e) {
      emit(RegisterFailedState(error: e.toString()));
    }
  }
}
