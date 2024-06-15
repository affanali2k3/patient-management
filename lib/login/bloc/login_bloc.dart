import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitEvent>(_login);
  }

  void _login(LoginSubmitEvent event, emit) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      final userDataJson = await FirebaseFirestore.instance
          .collection('users')
          .doc(event.email)
          .get();

      late Map<String, String> user;

      final jobType = userDataJson['job_type'];

      if (jobType == 'Doctor') {
        user = <String, String>{
          "email": userDataJson['email'],
          "job_type": userDataJson['job_type'],
          "name": userDataJson['name'],
          "speciality": userDataJson['speciality']
        };
        emit(LoginSuccessState(userData: user, userType: 'Doctor'));
      } else {
        user = <String, String>{
          "email": userDataJson['email'],
          "job_type": userDataJson['job_type'],
          "name": userDataJson['name'],
        };
        emit(LoginSuccessState(userData: user, userType: 'Receptionist'));
      }
    } catch (e) {
      emit(LoginFailedState(error: e.toString()));
    }
  }
}
